//
//  ServiceClient.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class ApiService: StoriesApiServiceProtocol, CommentsApiServiceProtocol {
    enum StoriesApiServiceError: Int {
        case not200
        case incorrectData
        case incorrectUrl

        func errorCode() -> Int {
            return self.rawValue
        }
    }

    enum StoriesCategory: String {
        case topStories = "topstories"
        case newStories = "newstories"
        case bestStories = "beststories"

        func name() -> String {
            return self.rawValue
        }
    }

    private let deserializer: FeedItemDeserializerProtocol = FeedItemDeserializer()

    private static let feedItemUrl = "https://hacker-news.firebaseio.com/v0/item"
    private static let feedItemsUrl = "https://hacker-news.firebaseio.com/v0"

    func getStoryItems(ids: [Int],
                       onSuccess: @escaping ([StoryItem]) -> Void,
                       onFailure: @escaping (Error) -> Void) {
        getFeedItems(byIds: ids, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getCommentItems(ids: [Int],
                         onSuccess: @escaping ([CommentItem]) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        getFeedItems(byIds: ids, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getStoryAllIds(forCategory category: String,
                        onSuccess: @escaping ([Int]) -> Void,
                        onFailure: @escaping (Error) -> Void) {
        let urlString = "\(ApiService.feedItemsUrl)/\(category).json?"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if let error = error {
                onFailure(error)
                return
            }

            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let ids: [Int] = try self.deserializer.parseArray(fromData: data)
                    onSuccess(ids)
                    return
                } catch let error as NSError {
                    onFailure(error)
                    return
                }
            }

            let errorString = NSLocalizedString("MessageFailToConnect", comment: "")
            let error = NSError.init(domain: "ServiceClientError",
                                     code: StoriesApiServiceError.not200.errorCode(),
                                     userInfo: ["localizedDescription": errorString])
            onFailure(error)
        }

        task.resume()
    }

    func getFeedItemUrls(forIds ids: [Int]) -> [URL] {
        var urls: [URL] = []

        for identifier in ids {
            let urlString = "\(ApiService.feedItemUrl)/\(String(identifier)).json?"

            if let url = URL(string: urlString) {
                urls.append(url)
            }
        }

        return urls
    }

    func getFeedItems<T: Codable>(byIds ids: [Int],
                                  onSuccess: @escaping ([T]) -> Void,
                                  onFailure: @escaping (Error) -> Void) {
        let urls = getFeedItemUrls(forIds: ids)
        let operations = FeedItemDownloadAsyncOperation<T>.operationsWith(urls: urls)
        let groupOperation = FeedItemsDownloadOperation(operations: operations)

        groupOperation.completionBlock = {
            var storyItems: [T] = []

            for operation in operations {
                if let error = operation.error {
                    onFailure(error)
                    return
                }

                if let storyItem: T = operation.storyItem {
                    storyItems.append(storyItem)
                }
            }

            onSuccess(storyItems)
        }

        DispatchQueue.global().async {
            groupOperation.start()
        }
    }
}

extension ApiService {
    func getTopStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.topStories.name()
        self.getStoryAllIds(forCategory: type, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getNewStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.newStories.name()
        self.getStoryAllIds(forCategory: type, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getBestStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                            onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.bestStories.name()
        self.getStoryAllIds(forCategory: type, onSuccess: onSuccess, onFailure: onFailure)
    }
}
