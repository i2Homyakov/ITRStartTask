//
//  StoryItem.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

struct StoryItem: StoryItemProtocol, Codable {
    let identifier: Int
    let deleted: Bool?
    let author: String?
    let time: Int64
    let dead: Bool?
    let parent: Int?
    let poll: String?
    let kids: [Int]?
    let url: String?
    let score: Int?
    let title: String?
    let parts: [Int]?
    let descendants: Int?
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case deleted
        case author = "by"
        case time
        case dead
        case parent
        case poll
        case kids
        case url
        case score
        case title
        case parts
        case descendants
    }
}
