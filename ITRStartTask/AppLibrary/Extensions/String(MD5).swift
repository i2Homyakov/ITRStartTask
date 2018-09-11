//
//  String(MD5).swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 11/09/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

extension String {
    var md5: String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }

        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
