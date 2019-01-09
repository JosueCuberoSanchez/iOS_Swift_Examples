//
//  Starship.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Starship: Codable {
    
    let name: String
    let manufacturer: String
    let length: Double
    let passengers: Int
    let starshipClass: String
    
    init(name: String, manufacturer: String, length: Double, passengers: Int, starshipClass: String) {
        self.name = name
        self.manufacturer = manufacturer
        self.length = length
        self.passengers = passengers
        self.starshipClass = starshipClass
    }
}
