//
//  GAHomeConfigurator.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

class GAHomeConfigurator: NSObject {

    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "GAHomeSB", bundle: nil)
        let homeNVC = storyboard.instantiateViewController(identifier: "GAHomeNVC") as! UINavigationController
        let view = homeNVC.topViewController as! GAHomeVC
        let interactor = GAHomeInteractor()
        let router = GAHomeRouter()
        let presenter = GAHomePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return homeNVC
    }
}
