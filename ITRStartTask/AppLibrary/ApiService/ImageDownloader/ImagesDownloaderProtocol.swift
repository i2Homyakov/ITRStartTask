//
//  ImageDownloaderProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol ImagesDownloaderProtocol {
    func getImage(withUrl url: String,
                  onSuccess: @escaping (UIImage) -> Void,
                  onFailure: @escaping (Error) -> Void)

    func cancel(withUrl urlString: String)
}
