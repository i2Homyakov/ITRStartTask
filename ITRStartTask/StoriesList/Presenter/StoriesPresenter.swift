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
    private var storyImagesDownloader: ImagesDownloaderProtocol

    var storyImages: [String: UIImage]

    init(view: StoriesViewProtocol,
         storiesDataProvider: StoriesDataProviderProtocol,
         storyImagesDownloader: ImagesDownloaderProtocol) {
        self.storyItems = []
        self.storyImages = [:]
        self.view = view

        self.storiesDataProvider = storiesDataProvider
        self.storyImagesDownloader = storyImagesDownloader
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

    func getImage(forStoryItem storyItem: StoryItemProtocol) -> UIImage? {
        let imageHash = storyItem.getImageUrlHash()
        return self.storyImages[imageHash]
    }

    func downloadImage(forStoryItem storyItem: StoryItemProtocol,
                       onSuccess: @escaping (UIImage) -> Void,
                       onFailure: @escaping (Error) -> Void) {
        if let imageUrl = storyItem.imageUrl {
            self.storyImagesDownloader.getImage(withUrl: imageUrl, onSuccess: { (image) in
                let imageHash = storyItem.getImageUrlHash()
                self.storyImages[imageHash] = image
                onSuccess(image)
            }, onFailure: onFailure)
        }
    }

    func cancelImageDownload(forStoryItem storyItem: StoryItemProtocol) {
        if let imageUrl = storyItem.imageUrl {
            self.storyImagesDownloader.cancel(withUrl: imageUrl)
        }
    }
}
