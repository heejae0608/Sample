//
//  RetainCycleViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit
import SnapKit

/// 각 인스턴스들이 강한참조를 하는 상태라면 nil 로 할당해도 deinit 이 호출되지 않는다.
/// 이유는 강한참조를 하게되면 ARC(Automatic Reference Counting) 에 의해 참조카운트가 증가되는데
/// nil 로 할당하더라도 참조하고 있는 인스턴스가 해제되지 않아 참조카운트가 남아있어서 메모리릭 현상이 발생된다.
/// 해결하는 방법은 약한 참조(weak), 무소유 참조(unowned) 가 있는데 상황에 따라 할 수 있다.
/// weak 와 unowned 는 참조카운트를 증가시키지 않는다. weak 는 옵셔널이야하고 unowned 는 옵셔널이 아니어야한다. 그러기 때문에
/// nil 이 아니라는 확신이 있는 경우에만 사용해야한다.

final class Developer {
  let name: String
  
  init(name: String) {
    self.name = name
    print("Developer - \(#function) \(name)")
  }
  var company: Company?
  
  deinit {
    print("Developer - \(#function) \(name)")
  }
}

final class Company {
  let name: String
  
  init(name: String) {
    self.name = name
    print("Company - \(#function) \(name)")
  }
  weak var developer: Developer?
  
  deinit {
    print("Company - \(#function) \(name)")
  }
}

class RetainCycleViewController: BaseViewController {
  
  /// 메모리 해제 테스트를 위해 vc 전역변수로 설정
  private let alert = UIAlertController(title: "순환참조 테스트", message: "순환참조 시스템 알럿 테스트", preferredStyle: .alert)
  private let retainDelegate = DelegateRetainCycle()
  
  private let closureCaptureButton: BaseButton = {
    let button = BaseButton()
    button.setTitle("closure capture", for: .normal)
    return button
  }()
  
  private let showSystemAlertButton: UIButton = {
    let button = BaseButton()
    button.setTitle("System Alert", for: .normal)
    return button
  }()
  
  private let showCustomAlertButton: UIButton = {
    let button = BaseButton()
    button.setTitle("Custom Alert", for: .normal)
    return button
  }()
  
  private let delegateButton: BaseButton = {
    let button = BaseButton()
    button.setTitle("Delegate", for: .normal)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    var dev1: Developer?
    var company1: Company?

    dev1 = Developer(name: "Dev1")
    company1 = Company(name: "Company1")

    dev1?.company = company1
    company1?.developer = dev1

    dev1 = nil
    company1 = nil
    
    /// 강한 참조를 하면 메모리 릭 발생
    let action = UIAlertAction(title: "확인", style: .default) { [weak self] action in
      if let self = self {
        self.view.backgroundColor = self.view.backgroundColor
      }
    }
    alert.addAction(action)
  }
  
  override func initViews() {
    view.addSubview(closureCaptureButton)
    closureCaptureButton.addTarget(self, action: #selector(actionPushTimerVC), for: .touchUpInside)
    closureCaptureButton.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
    view.addSubview(showSystemAlertButton)
    showSystemAlertButton.addTarget(self, action: #selector(actionShowSystemAlert), for: .touchUpInside)
    showSystemAlertButton.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.top.equalTo(closureCaptureButton.snp.bottom).offset(12)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
    view.addSubview(showCustomAlertButton)
    showCustomAlertButton.addTarget(self, action: #selector(actionShowCustomAlert), for: .touchUpInside)
    showCustomAlertButton.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.top.equalTo(showSystemAlertButton.snp.bottom).offset(12)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
    view.addSubview(delegateButton)
    delegateButton.addTarget(self, action: #selector(actionPushDelegateVC), for: .touchUpInside)
    delegateButton.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.top.equalTo(showCustomAlertButton.snp.bottom).offset(12)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
  }
  
  /// 타이머 클로저 캡처 순환참조 테스트
  @objc private func actionPushTimerVC() {
    /// 타이머가 있는 화면에서 순환참조가 일어나는 경우 테스트
    let timerVC = TimerViewController()
    self.navigationController?.pushViewController(timerVC, animated: true)
  }
  
  /// 시스템 알럿 액션 순환참조 테스트
  @objc private func actionShowSystemAlert() {
    /// 알럿 action 이 클로저로 순환참조가 일어날 것 같아서 테스트
    /// 이 메소드안에서 생성하면 dismiss 될 때 alert 이 메모리에서 해제되서 순환참조가 자동으로 해소된다.
    present(alert, animated: true, completion: nil)
  }
  
  /// 커스텀 알럿 액션 순환참조 테스트
  @objc private func actionShowCustomAlert() {
    /// 커스텀 알럿은 지역변수로 순환참조가 자동으로 해소됨
    self.showAlert(title: "순환참조 테스트", content: "순환참조 커스텀 알럿 테스트\n") { [self] in
      self.view.backgroundColor = self.view.backgroundColor
    } cancelAction: {
      self.view.backgroundColor = self.view.backgroundColor
    }
  }
  
  /// Delegate 패턴 순환참조 테스트
  @objc private func actionPushDelegateVC() {
    /// Delegate 패턴을 통해 각 인스턴스들이 강함참조 하게되면 메모리 릭이 발생된다.
    /// weak 로 해결 할 수 있다.
    retainDelegate.delegate = self
  }
  
  deinit {
    print("RetainCycleViewController Deinit")
  }
}

extension RetainCycleViewController: RetainDelegate {}
