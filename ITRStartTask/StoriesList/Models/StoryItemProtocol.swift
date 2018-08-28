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

    func getDateString() -> String
}
