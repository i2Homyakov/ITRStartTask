//
//  CommentItem.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

struct CommentItem: CommentItemProtocol, Codable {
    let identifier: Int
    let deleted: Bool?
    let author: String?
    let time: Int64
    let text: String?
    let dead: Bool?
    let parent: Int?
    let kids: [Int]?
    let url: String?
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case deleted
        case author = "by"
        case time
        case text
        case dead
        case parent
        case kids
        case url
    }
}
