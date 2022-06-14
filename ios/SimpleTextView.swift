import Foundation

class SimpleTextView: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupView()
  }
  
  @objc var content: String = "" {
    didSet {
      self.text = content
    }
  }
  
  func setupView() {
    font = .systemFont(ofSize: 14)
    textAlignment = .center
    numberOfLines = 0
  }
}

