//
//  SimpleTextShadowView.swift
//  NativeModulesExample
//
//  Created by Георгий Мишин on 15.06.2022.
//

import Foundation
import React

func getHeight(for attributedString: NSAttributedString, font: UIFont, width: Float) -> Float {
    let textStorage = NSTextStorage(attributedString: attributedString)
    let textContainter = NSTextContainer(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    let layoutManager = NSLayoutManager()
    layoutManager.addTextContainer(textContainter)
    textStorage.addLayoutManager(layoutManager)
    textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, textStorage.length))
    textContainter.maximumNumberOfLines = 0
    textContainter.lineFragmentPadding = 0.0
    layoutManager.glyphRange(for: textContainter)
    return Float(layoutManager.usedRect(for: textContainter).size.height)
}

class SimpleTextShadowView: RCTShadowView {
  static let measure: YGMeasureFunc = {node, width , widthNode, height, heightNode in
    guard let context = YGNodeGetContext(node) else {
      return YGSize(width: 0, height: 0)
    }
    
    let instance = Unmanaged<SimpleTextShadowView>.fromOpaque(context).takeRetainedValue()
    let height = getHeight(
      for: NSAttributedString(string: instance.content),
      font: .systemFont(ofSize: 14),
      width: width)
    
    return YGSize(width: width, height: height)
    
  }
  
  @objc var content: String = ""
    
  override init() {
    super.init()
        
    YGNodeSetMeasureFunc(self.yogaNode!, SimpleTextShadowView.measure)
    YGNodeSetContext(self.yogaNode!, Unmanaged.passRetained(self).toOpaque())
  }
    
  override func layout(with layoutMetrics: RCTLayoutMetrics, layoutContext: RCTLayoutContext) {
    super.layout(with: layoutMetrics, layoutContext: layoutContext)
  }
}

