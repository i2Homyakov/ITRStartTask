//
//  ViewControllersFactory.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ViewControllersFactory {
    static func getStoryViewController(storyItem: StoryItemProtocol) -> UIViewController {
        let view: StoryViewController = StoryViewController.xibInstance()
        let dataProvider: CommentsDataProviderProtocol = CommentsDataProvider()
        let presenter = StoryPresenter(view: view, model: storyItem, commentsDataProvider: dataProvider)
        view.presenter = presenter

        return view
    }

    static func getStoryCategoriesTabBarController() -> UIViewController {
        let categoriesTabBarController = UITabBarController()
        categoriesTabBarController.title = NSLocalizedString("Stories", comment: "")

        let topStoriesViewController = getTopStoriesViewController()
        topStoriesViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("TopStories", comment: ""),
                                                 image: UIImage(named: "Like"),
                                                 tag: 0)

        let newStoriesViewController = getNewStoriesViewController()
        newStoriesViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("NewStories", comment: ""),
                                                 image: UIImage(named: "New"),
                                                 tag: 0)

        let bestStoriesViewController = getBestStoriesViewController()
        bestStoriesViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("BestStories", comment: ""),
                                                  image: UIImage(named: "Best"),
                                                  tag: 0)

        let viewControllers = [topStoriesViewController, newStoriesViewController, bestStoriesViewController]
        categoriesTabBarController.setViewControllers(viewControllers, animated: true)

        return categoriesTabBarController
    }

    private static func getTopStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let dataProvider: StoriesDataProviderProtocol = StoriesDataProvider(category: .top)
        let storyImagesDownloader: ImagesDownloaderProtocol = ImagesDownloader()
        let presenter = StoriesPresenter(view: view,
                                         storiesDataProvider: dataProvider,
                                         storyImagesDownloader: storyImagesDownloader)
        view.presenter = presenter

        return view
    }

    private static func getNewStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let dataProvider: StoriesDataProviderProtocol = StoriesDataProvider(category: .new)
        let storyImagesDownloader: ImagesDownloaderProtocol = ImagesDownloader()
        let presenter = StoriesPresenter(view: view,
                                         storiesDataProvider: dataProvider,
                                         storyImagesDownloader: storyImagesDownloader)
        view.presenter = presenter

        return view
    }

    private static func getBestStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let dataProvider: StoriesDataProviderProtocol = StoriesDataProvider(category: .best)
        let storyImagesDownloader: ImagesDownloaderProtocol = ImagesDownloader()
        let presenter = StoriesPresenter(view: view,
                                         storiesDataProvider: dataProvider,
                                         storyImagesDownloader: storyImagesDownloader)
        view.presenter = presenter

        return view
    }
}
