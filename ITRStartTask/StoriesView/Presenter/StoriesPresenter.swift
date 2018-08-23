//
//  StoriesPresnterImplementation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoriesPresenter: StoriesPresenterProtocol {
    unowned let view: StoriesViewProtocol
    private var storiesDataProvider: StoriesDataProviderProtocol
    fileprivate var storyItems: [StoryItem]

    init(view: StoriesViewProtocol, storiesDataProvider: StoriesDataProviderProtocol) {
        self.view = view
        self.storiesDataProvider = storiesDataProvider
        self.storyItems = []
    }

    func show() {
        if storyItems.count > 0 {
            return
        }

        self.view.showRootProgress()
        weak var weakSelf = self

        storiesDataProvider.getTopStoryItems(onSuccess: { (storyItems) in

            weakSelf?.storyItems = storyItems
            weakSelf?.view.refreshStories()
            weakSelf?.view.hideRootProgress()
        }, onFailure: { (error) in

            print(error.localizedDescription)
            weakSelf?.view.hideRootProgress()
        })
    }

    func getStoryItemsCount() -> Int {
        return storyItems.count
    }

    func getStoryItem(atIndex: Int) -> StoryItemProtocol? {
        if self.storyItems.indices.contains(atIndex) {
            return storyItems[atIndex]
        }

        return nil
    }
}
