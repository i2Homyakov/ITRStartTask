//
//  StoriesDownloader.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol StoriesApiServiceProtocol {
    func getTopStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void)

    func getNewStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void)

    func getBestStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                            onFailure: @escaping (Error) -> Void)

    func getStoryItems(ids: [Int],
                       onSuccess: @escaping ([StoryItem]) -> Void,
                       onFailure: @escaping (Error) -> Void)

}
