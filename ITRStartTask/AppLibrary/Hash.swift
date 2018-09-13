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
        if let string = object as? String {
            if let result = string.md5 {
                return result
            }

            assertionFailure("Error md5 hash")
            return ""
        }

        assertionFailure("Type not supported for hash generating")
        return ""
    }
}
