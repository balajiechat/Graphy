//
//  GAProfileInteractor.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol GAProfileInteractorOutputProtocol: class {

    func sendData(model: [GAProfile])

}

protocol GAProfileInteractorInputProtocol: class {

    var presenter: GAProfileInteractorOutputProtocol?  { get set }

    func getUserProfileData()

}

class GAProfileInteractor: GAProfileInteractorInputProtocol {

    weak var presenter: GAProfileInteractorOutputProtocol?

    func getUserProfileData() {
        var models = [GAProfile]()
        for section in GAProfileSection.allCases {
            var subTitle = ""
            var title = section.rawValue
            switch section {
            case .photo:
                subTitle = "Balaji Sivaji"
                title = "person.circle"

            case .mobile:
                subTitle = "+91 9008795766"

            case .email:
                subTitle = "balajiechat@gmail.com"

            case .address:
                subTitle = "JP Nagar 6th Phase,\nBangalore,\nKarnataka - 560078"
            }
            models.append(GAProfile(section: section, title: title, subTitle: subTitle))
        }

        self.presenter?.sendData(model: models)
    }
}
