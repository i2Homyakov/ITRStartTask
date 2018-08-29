//
//  StoryHeaderCell.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 24/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryHeaderCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
}

extension StoryHeaderCell {
    static let nibName = "StoryHeaderCell"
}
