//
//  ItemCell.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {
    @IBOutlet weak var titleUILabel: UILabel!

    var title: String? {
        set {
            titleUILabel.text = newValue
        }
        get {
            return titleUILabel.text
        }
    }
}

extension StoryCell {
    static let nibName = "StoryCell"
}
