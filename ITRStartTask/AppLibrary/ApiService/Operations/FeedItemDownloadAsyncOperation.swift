//
//  FeedItemDownloadOperation2.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 23/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class FeedItemDownloadAsyncOperation<T: Codable>: AsyncOperation {
    enum FeedItemDownloadAsyncOperationError: Int {
        case not200
        case incorrectData
        case operationCanceled
        case unknownError

        func errorCode() -> Int {
            return rawValue
        }

        func errorLocalizedDescription() -> String {
            switch self {
            case .not200:
                return NSLocalizedString("MessageFailToConnect", comment: "")
            case .incorrectData:
                return NSLocalizedString("IncorrectServerData", comment: "")
            case .operationCanceled:
                return NSLocalizedString("OperationCanceled", comment: "")
            case .unknownError:
                return NSLocalizedString("UnknownError", comment: "")
            }
        }

        func error() -> Error {
            return NSError.init(domain: "FeedItemDownloadAsyncOperationError",
                                code: errorCode(),
                                userInfo: ["localizedDescription": errorLocalizedDescription()])
        }
    }

    private let deserializer: FeedItemDeserializerProtocol = FeedItemDeserializer()

    var url: URL
    var storyItem: T?
    var error: Error?

    init(url: URL) {
        self.url = url
        super.init()
    }

    override func main() {
        if isCancelled {
            return
        }

        getFeedItem(url: url, onSuccess: { [weak self] (feedItem: T) in
            self?.storyItem = feedItem
            self?.state = .finished
        }, onFailure: { [weak self] error in
            self?.error = error
            self?.state = .finished
        })
    }

    private func getFeedItem<T: Codable>(url: URL,
                                         onSuccess: @escaping (T) -> Void,
                                         onFailure: @escaping (Error) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                onFailure(error)
                return
            }

            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    if let item: T = try self?.deserializer.parse(data: data) {
                        onSuccess(item)
                        return
                    }

                    onFailure(FeedItemDownloadAsyncOperationError.incorrectData.error())
                } catch let error as NSError {
                    onFailure(error)
                    return
                }

                return
            }

            if data == nil {
                onFailure(FeedItemDownloadAsyncOperationError.not200.error())

                return
            }

            onFailure(FeedItemDownloadAsyncOperationError.unknownError.error())
        }

        task.resume()
    }
}

extension FeedItemDownloadAsyncOperation {
    static func operationsWith(urls: [URL]) -> [FeedItemDownloadAsyncOperation] {
        return urls.map {FeedItemDownloadAsyncOperation(url: $0)}
    }
}
