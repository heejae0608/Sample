//
//  MainViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
  
  private let retainCycleButton: BaseButton = {
    let button = BaseButton()
    button.setTitle("순환참조", for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func initViews() {
    view.addSubview(retainCycleButton)
    retainCycleButton.addTarget(self, action: #selector(actionPushRetainCycleVC), for: .touchUpInside)
    retainCycleButton.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(30)
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
  }
  
  @objc private func actionPushRetainCycleVC() {
    let retainCycleVC = RetainCycleViewController()
    self.navigationController?.pushViewController(retainCycleVC, animated: true)
  }
}
