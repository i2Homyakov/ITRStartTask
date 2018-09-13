//
//  ApiServiceError.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 03/09/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import Foundation

enum ApiServiceError: Int {
    case not200
    case incorrectData
    case incorrectUrl
    case operationCanceled
    case unknownError

    func errorCode() -> Int {
        return self.rawValue
    }

    func errorMessage() -> String {
        let key: String

        switch self {
        case .not200:
            key = "MessageFailToConnect"
        case .incorrectData:
            key = "IncorrectServerData"
        case .incorrectUrl:
            key = "UnknownError"
        case .operationCanceled:
            key = "OperationCanceled"
        case .unknownError:
            key = "UnknownError"
        }

        return NSLocalizedString(key, comment: "")
    }

    func error() -> Error {
        return NSError.init(domain: "ApiServiceError",
                            code: self.errorCode(),
                            userInfo: [NSLocalizedDescriptionKey: self.errorMessage()])
    }
}
