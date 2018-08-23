//
//  DataProvider.swift
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
        weak var weakSelf = self

        apiServiceClient.getTopStoryIds (onSuccess: { (ids) in

//            weakSelf?.getStoryItems
            //****
            weakSelf?.apiServiceClient.getStoryItems(ids: Array(ids[0..<5]), onSuccess: { (storyItems) in

                DispatchQueue.main.async {
                    onSuccess(storyItems)
                }
            }, onFailure: { (error) in

                DispatchQueue.main.async {
                    onFailure(error)
                }
            })
            //****
        }, onFailure: { (error) in

            DispatchQueue.main.async {
                onFailure(error)
            }
        })
    }

    // otherMethods
//    private func getStoryItems(ids: [Int],
//                               onSuccess: @escaping ([StoryItem]) -> Void,
//                               onFailure: @escaping (Error) -> Void) {
//        let firstId = ids[0]
//
//        apiServiceClient.getStoryItem(identifier: firstId, onSuccess: { (item) in
//
//            //****
//            let items = [item, item, item, item, item, item, item, item,
//                          item, item, item, item, item, item, item, item]
//            //****
//
//            DispatchQueue.main.async {
//                onSuccess(items)
//            }
//        }, onFailure: { (error) in
//
//            DispatchQueue.main.async {
//                onFailure(error)
//            }
//        })
//    }
}
