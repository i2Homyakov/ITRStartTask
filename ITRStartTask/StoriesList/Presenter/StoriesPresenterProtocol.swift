//
//  StoriesPresnter.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol StoriesPresenterProtocol {
    func show()

    func getStoryItemsCount() -> Int

    func getStoryItem(atIndex: Int) -> StoryItemProtocol?

    func getImage(forStoryItem storyItem: StoryItemProtocol) -> UIImage?

    func donwloadImage(forStoryItem storyItem: StoryItemProtocol,
                       onSuccess: @escaping (UIImage) -> Void,
                       onFailure: @escaping (Error) -> Void)

    func cancelImageDownload(forStoryItem storyItem: StoryItemProtocol)
}
