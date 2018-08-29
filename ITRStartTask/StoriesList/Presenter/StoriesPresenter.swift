//
//  StoriesPresnterImplementation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoriesPresenter: StoriesPresenterProtocol {
    fileprivate var storyItems: [StoryItem]
    unowned let view: StoriesViewProtocol

    private var storiesDataProvider: StoriesDataProviderProtocol
    private var storyImagesProvider: StoryImagesProviderProtocol

    var imageSetters: [Int: (UIImage?, Error?) -> Void]

    init(view: StoriesViewProtocol,
         storiesDataProvider: StoriesDataProviderProtocol,
         storyImagesProvider: StoryImagesProviderProtocol) {
        self.storyItems = []
        self.view = view

        self.storiesDataProvider = storiesDataProvider
        self.storyImagesProvider = storyImagesProvider

        imageSetters = [:]
    }

    func show() {
        if storyItems.count > 0 {
            self.view.refreshStories()
            return
        }

        self.view.showRootProgress()

        storiesDataProvider.getTopStoryItems(onSuccess: { [weak self] (storyItems) in
            self?.storyItems = storyItems
            self?.view.refreshStories()
            self?.view.hideRootProgress()
        }, onFailure: { [weak self] (error) in

            print(error.localizedDescription)
            self?.view.hideRootProgress()
        })
    }

    func getStoryItemsCount() -> Int {
        return storyItems.count
    }

    func getStoryItem(atIndex: Int) -> StoryItemProtocol? {
        if 0 <= atIndex && atIndex < self.storyItems.count {
            return storyItems[atIndex]
        }

        return nil
    }

    func getImage(atIndex index: Int,
                  onComplete: @escaping (UIImage?, Error?) -> Void) {
        if imageSetters[index] != nil {
            return
        }

        imageSetters[index] = onComplete
        let urlString = getStoryItem(atIndex: index)?.imageUrl

        self.storyImagesProvider.getImage(withUrl: urlString, onComplete: { [weak self] (image, error) in
            if let imageSetter = self?.imageSetters[index] {
                imageSetter(image, error)
            }
        })
    }

    func cancelImageRequest(atIndex index: Int) {
        imageSetters[index] = nil
    }
}
