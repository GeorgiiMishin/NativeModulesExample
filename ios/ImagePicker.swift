import Foundation
import React
import UIKit
import PhotosUI

enum Code: String {
  case NotJPEG, TmpCreationError, TmpWriteError
}

@objc(ImagePicker)
class ImagePicker: NSObject, PHPickerViewControllerDelegate {
  @objc var bridge: RCTBridge!
  
  var resolve: RCTPromiseResolveBlock?
  var reject: RCTPromiseRejectBlock?
  
  private func prepare(_ result: PHPickerResult, _ success: @escaping (String) -> Void, _ failure: @escaping (Code, String, NSError?) -> Void) {
    let itemProvider = result.itemProvider
    
    let typeId = itemProvider.registeredTypeIdentifiers.last(where: {
      return itemProvider.hasRepresentationConforming(toTypeIdentifier: $0, fileOptions: .init())
    })
    
    guard let identifier = typeId else {
      failure(Code.NotJPEG, "Can not represent selected media", nil)
      return
    }
    
    itemProvider.loadDataRepresentation(forTypeIdentifier: identifier) { data, error in
      let error = ErrorPointer(nilLiteral: ())
      
      guard let tmpFile = RCTTempFilePath("jpg", error), let inputData = data, let uiImage = UIImage(data: inputData) else {
        failure(Code.TmpCreationError, "Can not create intermediate file", error?.pointee)
        return
      }
      
      let url = URL(fileURLWithPath: tmpFile)
      
      do {
        try uiImage.jpegData(compressionQuality: 1)?.write(to: url)
      } catch {
        failure(Code.TmpWriteError, "Can not write to intermediate file", nil)
        return
      }
      
      success(tmpFile)
    }
  }
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true, completion: nil)
    
    guard let resolve = resolve, let reject = reject else {
      return
    }
    
    
    if results.isEmpty {
      resolve(nil)
      return
    }
    
    prepare(results.first!) { url in
      resolve(url)
    } _: { code, message, error in
      reject(code.rawValue, message, error)
    }
  }
  
  
  @objc func selectPhoto(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    RCTExecuteOnMainQueue {
      self.resolve = resolve
      self.reject = reject
      
      guard let rootControlller = RCTPresentedViewController() else {
        return
      }
      var config = PHPickerConfiguration()
      config.selectionLimit = 1
      config.filter = .images
      let pickerController = PHPickerViewController(configuration: config)
      pickerController.delegate = self
      
      rootControlller.present(pickerController, animated: true, completion: nil)
    }
  }
  
  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
