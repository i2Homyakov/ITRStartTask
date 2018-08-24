//
//  МшуцСщтекщддукыАфсещкн.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ViewControllersFactory {
    static func getStoriesViewController () -> UIViewController {
        let view = UIViewController.storiesViewController()
        let presenter = StoriesPresenter(view: view, storiesDataProvider: StoriesDataProvider())
        view.presenter = presenter

        return view
    }

    static func getStoryViewController (storyItem: StoryItemProtocol) -> UIViewController {
        let view = UIViewController.storyViewController()
        let presenter = StoryPresenter(view: view, model: storyItem, commentsDataProvider: CommentsDataProvider())
        view.presenter = presenter

        return view
    }

}

extension UIViewController {
    static func storiesViewController () -> StoriesViewController {
        return StoriesViewController(nibName: "StoriesViewController", bundle: nil)
    }

    static func storyViewController () -> StoryViewController {
        return StoryViewController(nibName: "StoryViewController", bundle: nil)
    }
}
