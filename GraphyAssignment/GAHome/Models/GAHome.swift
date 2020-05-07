//
//  GAHome.swift
//  GraphyAssignment
//
//  Created Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

struct GAHome: Codable {
    let videos: [GAHomeList]?
}

struct GAHomeList: Codable {
    let id: Int
    let title: String?
    let description: String?
    let video: String?
    let image: String?
}
