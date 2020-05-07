//
//  GAProfile.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

enum GAProfileSection: String, CaseIterable {
    case photo
    case mobile = "Mobile Number"
    case email = "Email"
    case address = "Address"
}

struct GAProfile {

    var section: GAProfileSection?
    var title: String?
    var subTitle: String?

}
