//
//  GAVideoPlayerInteractor.swift
//  GraphyAssignment
//
//  Created Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAVideoPlayerInteractorOutputProtocol: class {

    func playVideo(url: URL?)

}

protocol GAVideoPlayerInteractorInputProtocol: class {

    var presenter: GAVideoPlayerInteractorOutputProtocol?  { get set }

    func playVideo()

}

class GAVideoPlayerInteractor: GAVideoPlayerInteractorInputProtocol {

    weak var presenter: GAVideoPlayerInteractorOutputProtocol?
    private var videoURL: URL?

    init(url: URL?) {
        videoURL = url
    }

    func playVideo() {
        if let url = videoURL {
            GAVideoDataManager.downloadAndSaveVideo(url: url) { (url) in
                self.presenter?.playVideo(url: url)
            }
        }
    }

}
