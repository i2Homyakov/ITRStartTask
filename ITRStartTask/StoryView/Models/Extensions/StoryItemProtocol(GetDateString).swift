//
//  StoryItem(GetDateString).swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 20/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

extension TimeProtocol {
    func getDateString () -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.time))
        let formatter = DateFormatter()
        formatter.dateFormat = Style.defaultListDateFormat.getFormatString()
        let string = formatter.string(from: date as Date)

        return string
    }
}
