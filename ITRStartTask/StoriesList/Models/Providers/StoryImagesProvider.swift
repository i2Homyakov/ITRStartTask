//
//  StoryImagesProvider.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 29/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class StoryImagesProvider: StoryImagesProviderProtocol {
    enum StoryImagesProviderError: Int {
        case not200
        case incorrectData
        case incorrectUrl
        case unknownError

        func errorCode() -> Int {
            return self.rawValue
        }

        func errorLocalizedDescription() -> String {
            switch self {
            case .not200:
                return NSLocalizedString("MessageFailToConnect", comment: "")
            case .incorrectData:
                return NSLocalizedString("IncorrectServerData", comment: "")
            case .incorrectUrl:
                return NSLocalizedString("UnknownError", comment: "")
            case .unknownError:
                return NSLocalizedString("UnknownError", comment: "")
            }
        }

        func error() -> Error {
            return NSError.init(domain: "StoryImagesProviderError",
                                code: self.errorCode(),
                                userInfo: ["localizedDescription": self.errorLocalizedDescription()])
        }
    }

    func getImage(withUrl urlString: String?,
                  onComplete: @escaping (UIImage?, Error?) -> Void) {
        guard let urlString = urlString else {
            onComplete(nil, StoryImagesProviderError.incorrectUrl.error())
            return
        }

        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)

                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async { onComplete(image, nil) }
                        return
                    }

                    DispatchQueue.main.async { onComplete(nil, StoryImagesProviderError.incorrectData.error()) }
                    return
                } catch {
                    DispatchQueue.main.async { onComplete(nil, error) }
                    return
                }
            }

            DispatchQueue.main.async { onComplete(nil, StoryImagesProviderError.incorrectUrl.error()) }
        }
    }
}
