//
//  StoriesDataProviderProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 16/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class StoriesDataProvider: StoriesDataProviderProtocol {
    static let maxIdsNumber = 5
    private var apiServiceClient: StoriesApiServiceProtocol = ApiService()

    func getTopStoryItems(onSuccess: @escaping ([StoryItem]) -> Void,
                          onFailure: @escaping (Error) -> Void) {

        apiServiceClient.getTopStoryAllIds (onSuccess: { [weak self] (ids) in
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
        }, onFailure: { (error) in

            DispatchQueue.main.async {
                onFailure(error)
            }
        })
    }
}
