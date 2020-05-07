//
//  GAHomePresenter.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAHomePresenterProtocol: class {

    var interactor: GAHomeInteractorInputProtocol? { get set }

    func getData()
    func playSelectedVideo(url: URL?)

}

class GAHomePresenter: GAHomePresenterProtocol {

    weak private var view: GAHomeViewProtocol?
    var interactor: GAHomeInteractorInputProtocol?
    private let router: GAHomeRouterProtocol

    init(interface: GAHomeViewProtocol, interactor: GAHomeInteractorInputProtocol?, router: GAHomeRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getData() {
        self.interactor?.getData()
    }

    func playSelectedVideo(url: URL?) {
        self.router.showVideoPlayerVC(url: url)
    }

}

extension GAHomePresenter: GAHomeInteractorOutputProtocol {

    func sendData(model: [GAHomeViewModel]?) {
        self.view?.updateUI(models: model)
    }

}
