//
//  GAVideoPlayerPresenter.swift
//  GraphyAssignment
//
//  Created Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAVideoPlayerPresenterProtocol: class {

    var interactor: GAVideoPlayerInteractorInputProtocol? { get set }

    func playVideo()
    func closeVideoPlayerVC()

}

class GAVideoPlayerPresenter: GAVideoPlayerPresenterProtocol {

    weak private var view: GAVideoPlayerViewProtocol?
    var interactor: GAVideoPlayerInteractorInputProtocol?
    private let router: GAVideoPlayerRouterProtocol

    init(interface: GAVideoPlayerViewProtocol, interactor: GAVideoPlayerInteractorInputProtocol?, router: GAVideoPlayerRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func playVideo() {
        self.interactor?.playVideo()
    }

    func closeVideoPlayerVC() {
        self.router.closeVideoPlayerVC()
    }

}

extension GAVideoPlayerPresenter: GAVideoPlayerInteractorOutputProtocol {

    func playVideo(url: URL?) {
        self.view?.playVideo(url: url)
    }

}
