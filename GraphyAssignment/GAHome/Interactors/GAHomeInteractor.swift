//
//  GAHomeInteractor.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAHomeInteractorOutputProtocol: class {

    func sendData(model: [GAHomeViewModel]?)

}

protocol GAHomeInteractorInputProtocol: class {

    var presenter: GAHomeInteractorOutputProtocol?  { get set }

    func getData()

}

class GAHomeInteractor: GAHomeInteractorInputProtocol {

    weak var presenter: GAHomeInteractorOutputProtocol?

    func getURL() -> URL {
        return URL(string: "https://jsonkeeper.com/b/CENN")!
    }

    func getData() {
        GADataManager.fetchFromDB { (videos) in
            if let videoList = videos, videoList.count > 0 {
                self.presenter?.sendData(model: videoList.map { GAHomeViewModel(model: $0) })
            } else {
                let resource = Resource<GAHome>(url: self.getURL())
                GADataManager.fetchDataFromServer(resource: resource) { (result) in
                    switch result {
                    case .success(let list):
                        if let videos = list.videos {
                            GADataManager.updateToDB(homeModels: videos)
                            self.getData()
                        } else {
                            self.presenter?.sendData(model: nil)
                        }
                    case .failure( _):
                        self.presenter?.sendData(model: nil)
                    }
                }
            }
        }
    }

}
