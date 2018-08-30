//
//  ImageDownloaderDelegate.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

protocol ImagesDownloaderDelegate: class {
    func onComplete(downloader: ImagesDownloaderProtocol, image: UIImage?, imageIndex: Int, error: Error?)
}
