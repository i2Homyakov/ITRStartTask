//
//  StoryItem.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 15/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

/*
 "by" : "dhouston",
 "descendants" : 71,
 "id" : 8863,
 "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940,
 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998,
 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
 "score" : 111,
 "time" : 1175714200,
 "title" : "My YC app: Dropbox - Throw away your USB drive",
 "type" : "story",
 "url" : "http://www.getdropbox.com/u/2/screencast.html"
 */

struct StoryItem: StoryItemProtocol, Codable {
    let identifier: Int
    let deleted: Bool?
    let author: String?
    let time: Int64
    let dead: Bool?
    let parent: Int?
    let poll: String? // непонятно нужно ли
    let kids: [Int]?
    let url: String?
    let score: Int?
    let title: String?
    let parts: [Int]? // непонятно нужно ли
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
