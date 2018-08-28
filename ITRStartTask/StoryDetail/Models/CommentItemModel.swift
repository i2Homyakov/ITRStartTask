//
//  CommentItemModel.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 24/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class CommentItemModel: CommentItemModelProtocol {
    private(set) var author: String?
    private(set) var time: Date
    private(set) var textAttributedString: NSAttributedString?

    init(commentItem: CommentItem) {
        textAttributedString = commentItem.text?.htmlToAttributedString
        author = commentItem.author
        time = commentItem.getDate()
    }

    func getFormattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Style.defaultListDateFormat.getFormatString()

        let string = formatter.string(from: self.time)

        return string
    }
}
