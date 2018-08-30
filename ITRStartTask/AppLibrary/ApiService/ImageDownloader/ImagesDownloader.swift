//
//  ImageDownloader.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ImagesDownloader: ImagesDownloaderProtocol {
    private let queue = OperationQueue()
    private var operations: [Int: ImageDownloadOperation] = [:]

    weak var delegate: ImagesDownloaderDelegate?

    func getImage(withUrl urlString: String, atIndex index: Int) {
        if self.operations[index] != nil {
            return
        }

        let operation = ImageDownloadOperation(urlString: urlString)
        self.operations[index] = operation

        operation.completionBlock = {
            DispatchQueue.main.async {
                self.delegate?.onComplete(downloader: self,
                                          image: operation.image,
                                          imageIndex: index,
                                          error: operation.error)

                self.operations[index] = nil
            }
        }

        queue.addOperation(operation)
    }

    func cancel(withIndex index: Int) {
        if let operation = self.operations[index] {
            operation.cancel()
            self.operations[index] = nil
        }
    }
}
