//
//  AppDelegate.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 14/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = ViewControllersFactory.getStoriesViewController()
        let navigationVontroller = UINavigationController(rootViewController: rootViewController)

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = navigationVontroller
        window.makeKeyAndVisible()

        return true
    }

}
