//
//  BaseAlertViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit

class BaseAlertViewController: BaseViewController {
  private var okAction: callBack = nil
  private var cancelActin: callBack = nil
  
  let dimView: UIView = {
    let view = UIView()
    view.backgroundColor = .black.withAlphaComponent(0.5)
    return view
  }()
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 5
    return view
  }()
  
  let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
  }()
  
  let contentLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13)
    label.textAlignment = .center
    label.numberOfLines = 3
    return label
  }()
  
  let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    stackView.spacing = 1
    return stackView
  }()
  
  let okButton: BaseButton = {
    let button = BaseButton()
    button.setTitle("확인", for: .normal)
    return button
  }()
  
  let cancelButton: BaseButton = {
    let button = BaseButton()
    button.setTitle("취소", for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setupAlert(
    title: String? = "알림",
    content: String? = "",
    okAction: callBack,
    cancelAction: callBack) {
      self.titleLabel.text = title
      self.contentLabel.text = content
      self.okAction = okAction
      self.cancelActin = cancelAction
      
      if cancelAction != nil {
        buttonStackView.addArrangedSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(actionCancel), for: .touchUpInside)
      }
      
      buttonStackView.addArrangedSubview(okButton)
    }
  
  override func initViews() {
    view.backgroundColor = .clear
    view.addSubview(dimView)
    dimView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    view.addSubview(contentView)
    contentView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(30)
    }
    
    contentStackView.addArrangedSubview(titleLabel)
    contentStackView.addArrangedSubview(contentLabel)
    contentStackView.addArrangedSubview(buttonStackView)
    
    contentView.addSubview(contentStackView)
    contentStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(12)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    okButton.addTarget(self, action: #selector(actionOK), for: .touchUpInside)
  }
  
  @objc private func actionOK() {
    self.dismiss(animated: true)
    self.okAction?()
  }
  
  @objc private func actionCancel() {
    self.dismiss(animated: true)
    self.cancelActin?()
  }
}
