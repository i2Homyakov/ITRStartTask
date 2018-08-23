//
//  CommentItem.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

/*
 "by" : "norvig",
 "id" : 2921983,
 "kids" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
 "parent" : 2921506,
 "text" : "Aw shucks, guys ... you make me blush with your compliments.
 <p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
 "time" : 1314211127,
 "type" : "comment"
 */

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
