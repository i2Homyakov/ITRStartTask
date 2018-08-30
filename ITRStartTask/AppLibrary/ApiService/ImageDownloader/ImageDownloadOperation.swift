//
//  ImageDownloadOperation.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class ImageDownloadOperation: AsyncOperation {
    enum ImageDownloadOperationError: Int {
        case not200
        case incorrectData
        case incorrectUrl
        case operationCanceled
        case unknownError

        func errorCode() -> Int {
            return self.rawValue
        }

        func errorMessage() -> String {
            switch self {
            case .not200:
                return NSLocalizedString("MessageFailToConnect", comment: "")
            case .incorrectData:
                return NSLocalizedString("IncorrectServerData", comment: "")
            case .incorrectUrl:
                return NSLocalizedString("UnknownError", comment: "")
            case .operationCanceled:
                return NSLocalizedString("OperationCanceled", comment: "")
            case .unknownError:
                return NSLocalizedString("UnknownError", comment: "")
            }
        }

        func error() -> Error {
            return NSError.init(domain: "ImageDownloadOperationError",
                                code: self.errorCode(),
                                userInfo: ["localizedDescription": self.errorMessage()])
        }
    }

    var urlString: String
    var image: UIImage?
    var error: Error?

    init(urlString: String) {
        self.urlString = urlString
        super.init()
    }

    override func main() {
        self.getImage(urlString: self.urlString)

        if isCancelled {
            return
        }

        self.state = .finished
    }

    private func getImage(urlString: String) {
        if isCancelled {
            return
        }

        guard let url = URL(string: urlString) else {
            self.error = ImageDownloadOperationError.incorrectUrl.error()
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

            self.error = ImageDownloadOperationError.incorrectData.error()
            return
        } catch {
            self.error = error
            return
        }
    }

    override func cancel() {
        self.error = ImageDownloadOperationError.operationCanceled.error()
        super.cancel()
    }
}
