//
//  StoriesView.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol StoriesViewProtocol: class {
    func refreshStories()

    func showRootProgress()

    func hideRootProgress()
}
