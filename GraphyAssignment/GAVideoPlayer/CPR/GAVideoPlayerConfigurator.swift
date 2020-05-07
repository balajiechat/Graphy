//
//  GAVideoPlayerConfigurator.swift
//  GraphyAssignment
//
//  Created Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

class GAVideoPlayerConfigurator: NSObject {

    static func createModule(url: URL?) -> UIViewController {
        let storyboard = UIStoryboard(name: "GAVideoPlayerSB", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "GAVideoPlayerVC") as! GAVideoPlayerVC
        let interactor = GAVideoPlayerInteractor(url: url)
        let router = GAVideoPlayerRouter()
        let presenter = GAVideoPlayerPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
