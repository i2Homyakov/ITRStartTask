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

    var storyImages: [Int: UIImage]

    init(view: StoriesViewProtocol,
         storiesDataProvider: StoriesDataProviderProtocol,
         storyImagesDownloader: ImagesDownloaderProtocol) {
        self.storyItems = []
        self.view = view

        self.storiesDataProvider = storiesDataProvider
        self.storyImagesDownloader = storyImagesDownloader

        self.storyImages = [:]
        self.storyImagesDownloader.delegate = self
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

    func getImage(atIndex index: Int) -> UIImage? {
        guard let image = self.storyImages[index] else {
            if let imageUrl = self.getStoryItem(atIndex: index)?.imageUrl {
                self.storyImagesDownloader.getImage(withUrl: imageUrl, atIndex: index)
            }

            return nil
        }

        return image
    }

    func cancelImageRequest(atIndex index: Int) {
        self.storyImagesDownloader.cancel(withIndex: index)
    }
}

extension StoriesPresenter: ImagesDownloaderDelegate {
    func onComplete(downloader: ImagesDownloaderProtocol, image: UIImage?, imageIndex: Int, error: Error?) {
        if let image = image {
            self.storyImages[imageIndex] = image
        }

        view.setStoryImage(atIndex: imageIndex, image: image)
    }
}
