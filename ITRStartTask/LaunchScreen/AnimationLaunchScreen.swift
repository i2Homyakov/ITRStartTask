//
//  AnimationLaunchScreen.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 29/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class AnimationLaunchScreen: UIViewController, XibInitializable {
    let targetAlpha: CGFloat = 0
    let targetPart: CGFloat = 0.1
    let duration: TimeInterval = 1.5

    @IBOutlet weak var logoView: UIView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: duration, animations: {
            self.view.alpha = self.targetAlpha
            self.logoView.transform = CGAffineTransform(scaleX: self.targetPart, y: self.targetPart)
        }, completion: { [weak self] (_ finished) in
            self?.dismiss(animated: false, completion: nil)
        })
    }
}
