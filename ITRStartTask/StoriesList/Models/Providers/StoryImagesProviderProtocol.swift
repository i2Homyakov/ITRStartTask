//
//  StoryImagesProviderProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 29/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol StoryImagesProviderProtocol {
    func getImage(withUrl url: String?,
                  onComplete: @escaping (UIImage?, Error?) -> Void)
}
