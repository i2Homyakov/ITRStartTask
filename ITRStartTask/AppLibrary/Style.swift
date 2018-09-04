//
//  Style.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 21/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

enum DateFormats: String {
    case full = "yyyy-MM-dd HH:mm:ss"
    case short = "yyyy-MM-dd"

    func getFormatString() -> String {
        return rawValue
    }
}

class Style {
    static let defaultListDateFormat = DateFormats.full
    static let storiesListDateFormat = DateFormats.full
}
