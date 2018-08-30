//
//  ViewControllersFactory.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ViewControllersFactory {
    static func getStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let storyImagesDownloader: ImagesDownloaderProtocol = ImagesDownloader()

        let presenter = StoriesPresenter(view: view,
                                         storiesDataProvider: StoriesDataProvider(),
                                         storyImagesDownloader: storyImagesDownloader)
        view.presenter = presenter

        return view
    }

    static func getStoryViewController(storyItem: StoryItemProtocol) -> UIViewController {
        let view: StoryViewController = StoryViewController.xibInstance()
        let presenter = StoryPresenter(view: view, model: storyItem, commentsDataProvider: CommentsDataProvider())
        view.presenter = presenter

        return view
    }

}
