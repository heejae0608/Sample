//
//  BaseViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit

typealias callBack = (()->())?

protocol BaseProtocol {
  func initViews()
}

class BaseViewController: UIViewController, BaseProtocol {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initViews()
  }
  
  
  func initViews() {}
}

extension BaseViewController {
  func showAlert(
    title: String?,
    content: String?,
    okAction: callBack,
    cancelAction: callBack) {
      let alertVC = BaseAlertViewController()
      alertVC.setupAlert(title: title, content: content, okAction: okAction, cancelAction: cancelAction)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
  }
}
