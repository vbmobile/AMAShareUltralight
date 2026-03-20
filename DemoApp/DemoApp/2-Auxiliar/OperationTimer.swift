//
//  OperationTimer.swift
//  DemoApp
//
//  Created by Ricardo DOS SANTOS on 10/03/2026.
//

import CoreFoundation

final class OperationTimer {
    static let shared = OperationTimer()
    private var timers: [String: CFAbsoluteTime] = [:]
    private init() {}
    
    func start(id: String) {
        timers[id] = CFAbsoluteTimeGetCurrent()
    }
    
    @discardableResult
    func end(id: String) -> Double? {
        guard let start = timers[id] else { return nil }
        let elapsed = CFAbsoluteTimeGetCurrent() - start
        timers.removeValue(forKey: id)
        return elapsed
    }
}
