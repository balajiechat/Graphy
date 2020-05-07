//
//  GAHomeCell.swift
//  GraphyAssignment
//
//  Created by Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit
import SDWebImage

class GAHomeCell: UICollectionViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    var model: GAHomeViewModel? {
        didSet {
            titleLabel.text = model?.title
            subTitleLabel.text = model?.subTitle
            videoImageView.sd_setImage(with: model?.imageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
