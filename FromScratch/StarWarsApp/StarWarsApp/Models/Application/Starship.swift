//
//  Starship.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Starship: Codable {
    let passengers: Int
    let length: Double
    let name: String
    let manufacturer: String
    let starshipClass: String
}
