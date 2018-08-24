//
//  ЫещкшуыВфефЗкщмшвукЗкщещсщд.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 16/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol StoriesDataProviderProtocol {
    func getTopStoryItems(onSuccess: @escaping ([StoryItem]) -> Void,
                          onFailure: @escaping (Error) -> Void)
}
