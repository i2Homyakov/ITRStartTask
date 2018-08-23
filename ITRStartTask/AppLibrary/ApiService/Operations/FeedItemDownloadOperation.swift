//
//  FeedItemDownloadOperation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class FeedItemDownloadOperation<T: Codable>: AsyncOperation {
    enum StoryItemDownloadOperationError: Int {
        case incorrectData
        case incorrectUrl

        func errorCode() -> Int {
            return self.rawValue
        }
    }

    private let deserializer: FeedItemDeserializerProtocol = FeedItemDeserializer ()

    var url: URL
    var storyItem: T?
    var error: Error?

    init (url: URL) {
        self.url = url
        super.init()
    }

    override func execute() {
        do {
            self.storyItem = try self.getItem(url: self.url)
        } catch {
            self.error = error
        }
    }

    // otherMethods
    private func getItem <T: Codable> (url: URL) throws -> T? {
        let data = try Data(contentsOf: url)

        if let item: T = try self.deserializer.parse(data: data) {
            return item
        }

        let error = NSError.init(domain: "StoryItemDownloadOperationError",
                                 code: StoryItemDownloadOperationError.incorrectData.errorCode(),
                                 userInfo: ["localizedDescription": "incorrect data from server"])

        throw error
    }
}

extension FeedItemDownloadOperation {
    static func operationsWith (urls: [URL]) -> [FeedItemDownloadOperation] {
        var operations: [FeedItemDownloadOperation] = []

        for url in urls {
            operations.append(FeedItemDownloadOperation(url: url))
        }

        return operations
    }
}
