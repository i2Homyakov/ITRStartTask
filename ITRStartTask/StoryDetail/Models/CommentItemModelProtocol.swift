//
//  CommentItemModelProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 24/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol CommentItemModelProtocol {
    var textAttributedString: NSAttributedString? { get }
    var author: String? { get }

    func getFormattedDateString() -> String
}
