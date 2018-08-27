//
//  StoriesDownloader.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

enum StoriesCategory: String {
    case topStories = "topstories"
    case newStories = "newstories"
    case bestStories = "beststories"

    func name() -> String {
        return self.rawValue
    }
}

protocol StoriesApiServiceProtocol {
    func getStoryAllIds(type: String,
                        onSuccess: @escaping ([Int]) -> Void,
                        onFailure: @escaping (Error) -> Void)

    func getStoryItems(ids: [Int],
                       onSuccess: @escaping ([StoryItem]) -> Void,
                       onFailure: @escaping (Error) -> Void)

}

extension StoriesApiServiceProtocol {
    func getTopStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.topStories.name()
        self.getStoryAllIds(type: type, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getNewStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.newStories.name()
        self.getStoryAllIds(type: type, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getBestStoryAllIds(onSuccess: @escaping ([Int]) -> Void,
                            onFailure: @escaping (Error) -> Void) {
        let type = StoriesCategory.bestStories.name()
        self.getStoryAllIds(type: type, onSuccess: onSuccess, onFailure: onFailure)
    }
}
