//
//  GACellAnimator.swift
//  GraphyAssignment
//
//  Created by Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    func animateCell() {
        self.layoutIfNeeded()
        var transform = CATransform3DIdentity
        transform = CATransform3DScale(transform, 0.5, 0.5, 0.5)
        let view = self.contentView
        view.layer.transform = transform
        view.layer.opacity = 0.8

        UIView.animate(withDuration: 0.4, animations: {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        })
    }

}
