//
//  FeedItemDeserializer.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol FeedItemDeserializerProtocol {
    func parse <T: Codable>(data: Data) throws -> T?

    func parseArray <T: Codable>(fromData: Data) throws -> [T]

}
