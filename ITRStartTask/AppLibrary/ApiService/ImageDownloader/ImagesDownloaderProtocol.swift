//
//  ImageDownloaderProtocol.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

protocol ImagesDownloaderProtocol {
    var delegate: ImagesDownloaderDelegate? { get set }

    func getImage(withUrl url: String, atIndex index: Int)

    func cancel(withIndex index: Int)
}
