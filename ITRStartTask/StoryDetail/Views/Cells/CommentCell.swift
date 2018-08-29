//
//  CommentCell.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 22/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!

    var dateString: String? {
        set {
            dateLabel.text = newValue
        }
        get {
            return dateLabel.text
        }
    }
    var author: String? {
        set {
            authorLabel.text = newValue
        }
        get {
            return authorLabel.text
        }
    }
    var commentText: NSAttributedString? {
        set {
            commentTextLabel.attributedText = newValue
        }
        get {
            return commentTextLabel.attributedText
        }
    }

}

extension CommentCell {
    static let nibName = "CommentCell"
}
