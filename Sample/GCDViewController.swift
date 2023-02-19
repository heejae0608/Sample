//
//  GCDViewController.swift
//  Sample
//
//  Created by 히재 on 2023/02/19.
//

import UIKit

class GCDViewController: BaseViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Grand Central Dispatch 이하 GCD 는 동시성 프로그래밍을 말하는 것이며,
    /// Dispatch Queue 는 GCD 를 지원하는 API 라고 보면된다.
   
    /// Dispatch Queue 의 종류
    /// Serial Dispatch Queue - 등록된 작업을 하나씩 순차적으로 처리
    /// Concurrent Dispatch Queue - 등록된 작업을 동시에 처리
    
    /// Queue 에 작업을 보내는 방법
    /// Sync - 동기, 큐로 보낸 작업이 완료되야 다음 작업 실행
    /// Async - 비동기, 큐로 보낸 작업의 완료 여부에 상관없이 다음 작업 실행
    
    /// 4가지 조합
    /// Serial - Sync
    /// Concurrent - Sync
    /// Serial - Async
    /// Concurrent - Aync
    
    /// Main Queue - 메인스레드에서 처리되는 Serial Queue
    /// Global Queue - 전체적으로 공유되는 Concurrent Queue, QoS 우선 순위 있음.
    /// Custom Queue - 사용자 임의로 만드는 Queue

    /// Main Qeue 에서 Sync 로 사용하게되면 앱의 이벤트를 처리하던 메인 스레드가 멈추게되어 dead lock 발생
    
//    serialQueueWithSync()
//    concurrentQueueWithSync()
//    serialQueueWithAsync()
//    concurrentQeueWithAsync()
  }
  
  /// 작업을 Sync 로 보내며, 등록된 작업을 순차적으로 처리
  /// 비동기 작업 순차적 전달 -> 등록된 작업이 종료되면 다음 작업 진행
  private func serialQueueWithSync() {
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    serialQueue.sync {
      for i in 1...3 {
        Task {
          let result = try await APIService.shared.fetchSamplePost(with: i)
          print("🐱 - \(result.id)")
        }
      }
    }
  }
  
  /// 작업을 Sync 로 보내며, 등록된 작업을 동시에 처리
  /// 비동기 작업 순차적 전달 -> 등록된 작업이 종료되지 않더라도 작업 실행
  private func concurrentQueueWithSync() {
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    concurrentQueue.sync {
      for i in 1...3 {
        Task {
          let result = try await APIService.shared.fetchSamplePost(with: i)
          print("🐱 - \(result.id)")
        }
      }
    }
  }
  
  
  /// 작업을 Async 로 보내며, 등록된 작업을 순차적으로 처리
  /// 작업이 보내지는 순서는 알 수 없으며 등록된 순차적으로 처리
  private func serialQueueWithAsync() {
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    serialQueue.async {
      for i in 1...3 {
        Task {
          let result = try await APIService.shared.fetchSamplePost(with: i)
          print("🐱 - \(result.id)")
        }
      }
    }
  }
  
  /// 작업을 Async 로 보내며, 등록된 작업을 동시에 처리
  /// 작업이 보내지는 순서도 알 수 없으며, 결과 순서도 알 수 없음
  private func concurrentQeueWithAsync() {
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    concurrentQueue.async {
      for i in 1...3 {
        Task {
          let result = try await APIService.shared.fetchSamplePost(with: i)
          print("🐱 - \(result.id)")
        }
      }
    }
  }
}
