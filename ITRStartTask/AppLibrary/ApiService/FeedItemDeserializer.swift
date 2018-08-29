//
//  FeedItemDeserializer.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 17/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class FeedItemDeserializer: FeedItemDeserializerProtocol {
    func parse <T: Codable>(data: Data)throws -> T? {
        let decoder = JSONDecoder()
        let item: T? = try decoder.decode(T.self, from: data)
        return item
    }

    func parseArray <T: Codable>(fromData: Data) throws -> [T] {
        return try JSONDecoder().decode([T].self, from: fromData)
    }
}
