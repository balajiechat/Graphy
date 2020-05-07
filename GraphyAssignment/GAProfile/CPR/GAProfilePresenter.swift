//
//  GAProfilePresenter.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAProfilePresenterProtocol: class {

    var interactor: GAProfileInteractorInputProtocol? { get set }
    func getUserProfileData()

}

class GAProfilePresenter: GAProfilePresenterProtocol {

    weak private var view: GAProfileViewProtocol?
    var interactor: GAProfileInteractorInputProtocol?
    private let router: GAProfileRouterProtocol

    init(interface: GAProfileViewProtocol, interactor: GAProfileInteractorInputProtocol?, router: GAProfileRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getUserProfileData() {
        self.interactor?.getUserProfileData()
    }

}

extension GAProfilePresenter: GAProfileInteractorOutputProtocol {
    
    func sendData(model: [GAProfile]) {
        self.view?.updateUI(models: model)
    }

}
