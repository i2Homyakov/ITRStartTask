//
//  StoryItem(GetDateString).swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

extension TimeProtocol {
    func getDate () -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self.time))
    }
}
