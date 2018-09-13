//
//  StoryItemProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol StoryItemProtocol: TimeProtocol {
    var title: String? { get }
    var kids: [Int]? { get }
    var imageUrl: String? { get }

    func getDateString() -> String
}

extension StoryItemProtocol {
    func getImageUrlHash() -> String {
        if let imageUrl = self.imageUrl {
            return Hash.hash(forObject: imageUrl as AnyObject)
        }

        return ""
    }
}
