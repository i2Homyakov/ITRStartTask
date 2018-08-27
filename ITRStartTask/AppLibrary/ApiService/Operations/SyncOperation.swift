//
//  AsyncOperation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class SyncOperation: Operation {
    override var isAsynchronous: Bool {
        return false
    }

    private var isFinishedValue = false
    private var isExecutingValue = false

    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            isFinishedValue = newValue
            didChangeValue(forKey: "isFinished")
        }
        get {
            return isFinishedValue
        }
    }

    override var isExecuting: Bool {
        set {
            willChangeValue(forKey: "isExecuting")
            isExecutingValue = newValue
            didChangeValue(forKey: "isExecuting")
        }
        get {
            return isExecutingValue
        }
    }

    func execute() {
    }

    override func start() {
        isExecuting = true
        execute()
        isExecuting = false
        isFinished = true
    }
}
