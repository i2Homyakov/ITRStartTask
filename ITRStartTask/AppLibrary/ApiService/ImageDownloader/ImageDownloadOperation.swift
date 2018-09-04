//
//  ImageDownloadOperation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ImageDownloadOperation: AsyncOperation {
    var url: String
    var image: UIImage?
    var error: Error?

    init(url: String) {
        self.url = url
        super.init()
    }

    override func main() {
        self.getImage()

        if isCancelled {
            return
        }

        self.state = .finished
    }

    private func getImage() {
        if isCancelled {
            return
        }

        guard let url = URL(string: url) else {
            self.error = ApiServiceError.incorrectUrl.error()
            return
        }

        if isCancelled {
            return
        }

        do {
            let data = try Data(contentsOf: url)

            if isCancelled {
                return
            }

            if let image = UIImage(data: data) {
                self.image = image
                return
            }

            self.error = ApiServiceError.incorrectData.error()
            return
        } catch {
            self.error = error
            return
        }
    }

    override func cancel() {
        self.error = ApiServiceError.operationCanceled.error()
        super.cancel()
    }
}
