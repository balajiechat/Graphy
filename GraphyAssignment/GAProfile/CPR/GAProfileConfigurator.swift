//
//  GAProfileConfigurator.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

class GAProfileConfigurator: NSObject {

    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "GAProfileSB", bundle: nil)
        let homeNVC = storyboard.instantiateViewController(identifier: "GAProfileNVC") as! UINavigationController
        let view = homeNVC.topViewController as! GAProfileVC
        let interactor = GAProfileInteractor()
        let router = GAProfileRouter()
        let presenter = GAProfilePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return homeNVC
    }

}
