//
//  GAHomeRouter.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAHomeRouterProtocol: class {

    func showVideoPlayerVC(url: URL?)

}

class GAHomeRouter: GAHomeRouterProtocol {

    weak var viewController: UIViewController?

    func showVideoPlayerVC(url: URL?) {
        let videoPlayerVC = GAVideoPlayerConfigurator.createModule(url: url)
        viewController?.navigationController?.present(videoPlayerVC, animated: true, completion: nil)
    }
}
