//
//  StoryViewProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol StoryViewProtocol {
    func setDate(withString: String)

    func set(title: String?)

    func refreshComments()

    func showRootProgress()

    func hideRootProgress()
}
