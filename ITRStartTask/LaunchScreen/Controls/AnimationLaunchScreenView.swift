//
//  AnimationLaunchScreenView.swift
//  ITRStartTask
//
//  Created by Homyakov, Ilya2 on 30/08/2018.
//  Copyright © 2018 Homyakov, Ilya2. All rights reserved.
//

import UIKit

class AnimationLaunchScreenView: UIView {
    let targetAlpha: CGFloat = 0
    let targetPart: CGFloat = 0.1
    let duration: TimeInterval = 1.5

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func startAnimation() {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = self.targetAlpha
            self.logoView.transform = CGAffineTransform(scaleX: self.targetPart, y: self.targetPart)
        }, completion: { [weak self] (_ finished) in
            self?.removeFromSuperview()
        })
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("AnimationLaunchScreenView", owner: self, options: nil)

        if let contentView = self.contentView {
            addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = true
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
}

extension AnimationLaunchScreenView {
    func stretchToSuperview() {
        if let superview = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let views = ["view": self]

            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                             options: [],
                                                             metrics: nil,
                                                             views: views)

            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: views)

            superview.addConstraints(constraints)
        }
    }
}
