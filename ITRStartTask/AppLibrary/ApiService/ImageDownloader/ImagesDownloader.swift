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
    private var operations: [String: ImageDownloadOperation] = [:]

    func getImage(withUrl urlString: String,
                  onSuccess: @escaping (UIImage) -> Void,
                  onFailure: @escaping (Error) -> Void) {
        let urlHash = self.getHash(forString: urlString)

        if self.operations[urlHash] != nil {
            return
        }

        let operation = ImageDownloadOperation(urlString: urlString)

        operation.completionBlock = {
            DispatchQueue.main.async { [weak self] in
                if let image = operation.image {
                     onSuccess(image)
                } else if let error = operation.error {
                    onFailure(error)
                }

                self?.operations[urlHash] = nil
            }
        }

        self.operations[urlHash] = operation
        queue.addOperation(operation)
    }

    func cancel(withUrl urlString: String) {
        let urlHash = self.getHash(forString: urlString)

        if let operation = self.operations[urlHash] {
            operation.cancel()
            self.operations[urlHash] = nil
        }
    }

    private func getHash(forString string: String) -> String {
        return String(string.hashValue)
    }
}
