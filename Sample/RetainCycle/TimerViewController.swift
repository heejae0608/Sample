//
//  TimerViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/18.
//

import UIKit

class TimerViewController: BaseViewController {
  private let countLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private var timer: Timer = Timer()
  private var count: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    print(CFGetRetainCount(self))
    
    /// 여기서 weak or unowned 가 아닌 강한 참조를 하게 되면 클로저에 캡처되어 참조 카운트가 올라서
    /// 해당 뷰컨트롤러가 pop 되더라도 deinit 이 호출안되고 계속 타이머가 돈다.
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
      if let self = self {
        self.count += 1
        self.countLabel.text = "count : \(self.count)"
        print(CFGetRetainCount(self))
      }
    })
  }
  
  override func initViews() {
    view.addSubview(countLabel)
    countLabel.snp.makeConstraints { make in
      make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
  }
  
  deinit {
    print("TimerViewController Deinit")
    self.timer.invalidate()
  }

}
