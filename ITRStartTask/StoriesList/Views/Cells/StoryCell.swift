//
//  ItemCell.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleUILabel: UILabel!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageContainer: UIView!

    var title: String? {
        set {
            titleUILabel.text = newValue
        }
        get {
            return titleUILabel.text
        }
    }

    var dateString: String? {
        set {
            dateLabel.text = newValue
        }
        get {
            return dateLabel.text
        }
    }

    var storyImage: UIImage? {
        set {
            storyImageView.image = newValue
        }
        get {
            return storyImageView.image
        }
    }

    func hideImageProgress() {
        self.activityIndicatorView.stopAnimating()
    }

    func showImageProgress() {
        self.activityIndicatorView.startAnimating()
    }

    func hideImage() {
        imageContainer.isHidden = true
    }

    func reset() {
        hideImageProgress()
        imageContainer.isHidden = false
    }
}

extension StoryCell {
    static let nibName = "StoryCell"
}
