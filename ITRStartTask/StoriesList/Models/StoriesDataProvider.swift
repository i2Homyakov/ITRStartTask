//
//  ЫещкшуыВфефЗкщмшвук.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 16/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoriesDataProvider: StoriesDataProviderProtocol {
    private var apiServiceClient: StoriesApiServiceProtocol = ApiService()

    func getTopStoryItems(onSuccess: @escaping ([StoryItem]) -> Void,
                          onFailure: @escaping (Error) -> Void) {

        apiServiceClient.getTopStoryIds (onSuccess: { [weak self] (ids) in
            let ids = ids.count > 5 ? Array(ids[0..<5]) : ids

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
