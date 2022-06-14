import Foundation

@objc(SimpleTextViewManager)
class SimpleTextViewManager : RCTViewManager {
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    return SimpleTextView()
  }
  
  override func shadowView() -> RCTShadowView! {
    return SimpleTextShadowView()
  }
}
