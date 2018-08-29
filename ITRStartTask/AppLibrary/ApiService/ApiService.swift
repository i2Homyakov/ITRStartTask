//
//  ServiceClient.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation
import Darwin

class ApiService {
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

extension ApiService: StoriesApiServiceProtocol {
    // swiftlint:disable imageUrls, line_length
    private static let imageUrls = ["http://informationcommunicationtechnology.com/wp-content/uploads/2018/06/Images-111.jpg",
                                    "https://wallpaperbrowse.com/media/images/6986083-waterfall-images_Mc3SaMS.jpg",
                                    "https://wallpaperbrowse.com/media/images/Dubai-Photos-Images-Oicture-Dubai-Landmarks-800x600.jpg",
                                    "https://wallpaperbrowse.com/media/images/3848765-wallpaper-images-download.jpg",
                                    "https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg?auto=compress&cs=tinysrgb&h=350",
                                    "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350",
                                    "https://wallpaperbrowse.com/media/images/soap-bubble-1958650_960_720.jpg",
                                    "https://www.gettyimages.ca/gi-resources/images/Homepage/Hero/UK/CMS_Creative_164657191_Kingfisher.jpg",
                                    "https://media.istockphoto.com/photos/plant-growing-picture-id510222832?k=6&m=510222832&s=612x612&w=0&h=Pzjkj2hf9IZiLAiXcgVE1FbCNFVmKzhdcT98dcHSdSk=",
                                    "",
                                    "https://images.pexels.com/photos/248797/pexels-photo-248798.jpeg"]

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

    func getStoryItems(ids: [Int],
                       onSuccess: @escaping ([StoryItem]) -> Void,
                       onFailure: @escaping (Error) -> Void) {
        let imageUrls = ApiService.imageUrls

        getFeedItems(byIds: ids, onSuccess: { (feedItems: [StoryItem]) in
            var resultItems: [StoryItem] = []

            for index in 0..<feedItems.count {
                var feedItem = feedItems[index]
                let imageUrlIndex = Int(arc4random_uniform(UInt32(imageUrls.count)))

                let imageUrl = imageUrls[imageUrlIndex]
                feedItem.imageUrl = imageUrl == "" ? nil : imageUrl
                resultItems.append(feedItem)
            }

            onSuccess(resultItems)
        }, onFailure: onFailure)
    }
}

extension ApiService: CommentsApiServiceProtocol {
    func getCommentItems(ids: [Int],
                         onSuccess: @escaping ([CommentItem]) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        getFeedItems(byIds: ids, onSuccess: onSuccess, onFailure: onFailure)
    }
}
