//
//  GAHomeViewModel.swift
//  GraphyAssignment
//
//  Created by Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class GAHomeViewModel: NSObject {

    private let home: GAVideo

    init(model: GAVideo) {
        home = model
    }

    lazy var title: String? = {
        return home.title
    }()

    lazy var subTitle: String? = {
        return home.subTitle
    }()

    lazy var imageURL: URL? = {
        guard let image = home.image else { return nil }
        return URL(string: image)
    }()

    lazy var videoURL: URL? = {
        guard let video = home.video else { return nil }
        return URL(string: video)
    }()

}
