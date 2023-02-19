//
//  DelegateRetainCycle.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import Foundation

protocol RetainDelegate: AnyObject {
  
}

class DelegateRetainCycle {
  weak var delegate: RetainDelegate?
  
  deinit {
    print("DelegateRetainCycle Deinit")
  }
}
