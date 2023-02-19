//
//  BaseButton.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit

class BaseButton: UIButton {
  // MARK: - Initializers
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    
    customInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    customInit()
  }
  
  func customInit() {
    backgroundColor = .darkGray
    layer.cornerRadius = 5
  }
}
