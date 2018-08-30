//
//  StoriesDataProviderProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 16/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class StoriesDataProvider: StoriesDataProviderProtocol {
    static let maxIdsNumber = 30
    enum StoryCategory {
        case top
        case new
        case best
    }

    private let category: StoryCategory
    private var apiServiceClient: StoriesApiServiceProtocol = ApiService()

    init(category: StoryCategory) {
        self.category = category
    }

    func getStoryItems(onSuccess: @escaping ([StoryItem]) -> Void,
                       onFailure: @escaping (Error) -> Void) {

        let success: ([Int]) -> Void = { [weak self] (ids) in
            let maxIdsNumber = StoriesDataProvider.maxIdsNumber
            let ids = ids.count > maxIdsNumber ? Array(ids[0..<maxIdsNumber]) : ids

            self?.apiServiceClient.getStoryItems(ids: ids, onSuccess: { (storyItems) in
                DispatchQueue.main.async {
                    onSuccess(storyItems)
                }
            }, onFailure: { (error) in
                DispatchQueue.main.async {
                    onFailure(error)
                }
            })
        }

        let failure: (Error) -> Void  = { (error) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }

        switch category {
        case .top:
            apiServiceClient.getTopStoryAllIds(onSuccess: success, onFailure: failure)
        case .new:
            apiServiceClient.getNewStoryAllIds(onSuccess: success, onFailure: failure)
        case .best:
            apiServiceClient.getBestStoryAllIds(onSuccess: success, onFailure: failure)
        }
    }
}
