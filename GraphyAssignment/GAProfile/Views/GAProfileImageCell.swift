//
//  GAProfileImageCell.swift
//  GraphyAssignment
//
//  Created by Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class GAProfileImageCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!

    var model: GAProfile? {
        didSet {
            nameLabel.text = model?.subTitle
            userImageView.image = UIImage(systemName: model?.title ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.gradientView.backgroundColor = UIColor.clear
        if let backgroundLayer = GradientColor().gradientLayer {
            backgroundLayer.frame = self.gradientView.frame
            self.gradientView.layer.insertSublayer(backgroundLayer, at: 0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class GradientColor {
    var gradientLayer:CAGradientLayer?

    init() {
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(red: 74.0 / 255.0, green: 121.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0).cgColor
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer?.colors = [colorTop, colorBottom]
        self.gradientLayer?.locations = [0.0, 1.0]
    }

}
