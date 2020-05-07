//
//  GAVideoPlayerRouter.swift
//  GraphyAssignment
//
//  Created Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAVideoPlayerRouterProtocol: class {

    func closeVideoPlayerVC()

}

class GAVideoPlayerRouter: GAVideoPlayerRouterProtocol {

    weak var viewController: UIViewController?

    func closeVideoPlayerVC() {
        viewController?.dismiss(animated: true, completion: nil)
    }

}
