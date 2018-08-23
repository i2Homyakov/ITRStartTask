//
//  FeedItemDeserializer.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

typealias IntArray = [Int]

protocol FeedItemDeserializerProtocol {
    func parse <T: Codable>(data: Data) throws -> T?

    func parseIntArray(fromData: Data) throws -> [Int]

}
