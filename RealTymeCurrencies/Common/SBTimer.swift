//
//  SBTimer.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

final class SBTimer {
  
  typealias TimerHandler = () -> Void
  
  private var timeInterval: TimeInterval
  private var timerHandler: TimerHandler?
  
  private var _timer: Timer?
  
  private var timer: Timer? {
    if _timer != nil {
      return _timer
    } else {
      let t = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
      _timer = t
      return t
    }
  }
  
  init(timeInterval: TimeInterval, handler: TimerHandler?) {
    self.timeInterval = timeInterval
    self.timerHandler = handler
  }
  
  @objc private func timerTicked() {
    timerHandler?()
  }
  
  func stop() {
    timer?.invalidate()
    _timer = nil
  }
  
  public func start() {
    stop()
    timer?.fire()
  }
  
  deinit {
    timer?.invalidate()
  }
  
}
