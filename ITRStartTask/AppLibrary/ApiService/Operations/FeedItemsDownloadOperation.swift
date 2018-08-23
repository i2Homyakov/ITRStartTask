//
//  FeedItemsDownloadOperation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class FeedItemsDownloadOperation<T: Codable>: AsyncOperation {
    private let queue = OperationQueue()
    private var operations: [FeedItemDownloadOperation<T>]

    init(operations: [FeedItemDownloadOperation<T>]) {
        self.operations = operations
        super.init()
    }

    override func execute() {
        queue.addOperations(operations, waitUntilFinished: true)
    }
}
