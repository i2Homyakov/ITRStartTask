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
        let presenter = StoryPresenter(view: view, model: storyItem, commentsDataProvider: CommentsDataProvider())
        view.presenter = presenter

        return view
    }

    static func getStoryCategoriesTabBarController() -> UIViewController {
        let categoriesView = UITabBarController()
        categoriesView.title = NSLocalizedString("Stories", comment: "")

        let topStoriesView = self.getTopStoriesViewController()
        topStoriesView.tabBarItem = UITabBarItem(title: NSLocalizedString("TopStories", comment: ""),
                                                 image: UIImage.init(named: "Like"),
                                                 tag: 0)

        let newStoriesView = self.getNewStoriesViewController()
        newStoriesView.tabBarItem = UITabBarItem(title: NSLocalizedString("NewStories", comment: ""),
                                                 image: UIImage.init(named: "New"),
                                                 tag: 0)

        let bestStoriesView = self.getBestStoriesViewController()
        bestStoriesView.tabBarItem = UITabBarItem(title: NSLocalizedString("BestStories", comment: ""),
                                                 image: UIImage.init(named: "Best"),
                                                 tag: 0)

        categoriesView.setViewControllers([topStoriesView, newStoriesView, bestStoriesView], animated: true)

        return categoriesView
    }

    private static func getTopStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let presenter = StoriesPresenter(view: view, storiesDataProvider: StoriesDataProvider(category: .top))
        view.presenter = presenter

        return view
    }

    private static func getNewStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let presenter = StoriesPresenter(view: view, storiesDataProvider: StoriesDataProvider(category: .new))
        view.presenter = presenter

        return view
    }

    private static func getBestStoriesViewController() -> UIViewController {
        let view: StoriesViewController = StoriesViewController.xibInstance()
        let presenter = StoriesPresenter(view: view, storiesDataProvider: StoriesDataProvider(category: .best))
        view.presenter = presenter

        return view
    }
}
