//
//  Hash.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 04/09/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class Hash {
    static func get(forString string: String) -> String {
        return String(string.hashValue)
    }
}
