//
//  FeedItemDeserializer.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 17/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class FeedItemDeserializer: FeedItemDeserializerProtocol {
    func parse <T: Codable>(data: Data)throws -> T? {
        let decoder = JSONDecoder()
        let item: T?  = try decoder.decode(T.self, from: data)

        return item
    }

    func parseIntArray(fromData: Data) throws -> [Int] {
        return try JSONDecoder().decode(IntArray.self, from: fromData)
    }
}
