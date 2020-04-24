//
//  TimerManager.swift
//  Messenger
//
//  Created by Евгений on 22.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ControlTimer: class {
    func start(mode: RunLoop.Mode)
    func cancelTimerFire()
    func config(delayedFunc: @escaping () -> (), interval: Double)
}

class TimerManager: ControlTimer {
    private var timeInterval = 60.0
    private weak var timer: Timer?
    private var delayedFunc: (() -> ())?
    
    func start(mode: RunLoop.Mode) {
        timer?.invalidate()
        timer = nil
        let nextTimer = Timer(timeInterval: self.timeInterval,
                                             target: self,
                                             selector: #selector(TimerManager.fireNow),
                                             userInfo: nil,
                                             repeats: true)
        timer = nextTimer
        RunLoop.current.add(timer!, forMode: mode)
    }
    
    @objc private func fireNow() {
        delayedFunc?()
    }
    
    func cancelTimerFire() {
        timer?.invalidate()
        timer = nil
    }
    
    func config(delayedFunc: @escaping () -> (), interval: Double) {
        timer?.invalidate()
        timer = nil
        self.delayedFunc = delayedFunc
        self.timeInterval = interval
    }
}
