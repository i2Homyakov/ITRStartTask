//
//  StoriesPresnterImplementation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class StoriesPresenter: StoriesPresenterProtocol {
    unowned let view: StoriesViewProtocol
    private var storiesDataProvider: StoriesDataProviderProtocol
    fileprivate var storyItems: [StoryItem]

    init(view: StoriesViewProtocol, storiesDataProvider: StoriesDataProviderProtocol) {
        self.view = view
        self.storiesDataProvider = storiesDataProvider
        self.storyItems = []
    }
    func refresh() {
        storiesDataProvider.getStoryItems(onSuccess: { [weak self] storyItems in
            self?.storyItems = storyItems
            self?.view.endRefreshing()
            self?.view.refreshStories()
            }, onFailure: { [weak self] error in
                print(error.localizedDescription)
                self?.view.endRefreshing()
        })
    }

    func show() {
        if storyItems.count > 0 {
            view.refreshStories()
            return
        }

        view.showRootProgress()

        storiesDataProvider.getStoryItems(onSuccess: { [weak self] storyItems in
            self?.storyItems = storyItems
            self?.view.refreshStories()
            self?.view.hideRootProgress()
        }, onFailure: { [weak self] error in
            print(error.localizedDescription)
            self?.view.hideRootProgress()
        })
    }

    func getStoryItemsCount() -> Int {
        return storyItems.count
    }

    func getStoryItem(atIndex: Int) -> StoryItemProtocol? {
        if 0 <= atIndex && atIndex < storyItems.count {
            return storyItems[atIndex]
        }

        return nil
    }
}
