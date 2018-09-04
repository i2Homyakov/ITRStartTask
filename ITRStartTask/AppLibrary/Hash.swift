//
//  Hash.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 04/09/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

class Hash {
    static func hash(forObject object: AnyObject) -> String {
        if object is String {
            return String(object.hashValue)
        }

        assert(false, "Type not supported for hash generating")
        return ""
    }
}
