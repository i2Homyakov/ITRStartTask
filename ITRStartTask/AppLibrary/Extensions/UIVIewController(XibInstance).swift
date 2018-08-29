//
//  UIVIewController(XibInstance).swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 28/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

extension UIViewController {
    static func xibInstance<T: XibInitializable & UIViewController>() -> T {
        let nibName = String(describing: self)
        return T(nibName: nibName, bundle: nil)
    }
}
