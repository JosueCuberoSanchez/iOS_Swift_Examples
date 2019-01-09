//
//  Specie.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Specie: Codable {
    
    let name: String
    let classification: String
    let averageHeight: Int
    let homeworld: String
    let language: String
    
    init(name: String, classification: String, averageHeight: Int, homeworld: String, language: String) {
        self.name = name
        self.classification = classification
        self.averageHeight = averageHeight
        self.homeworld = homeworld
        self.language = language
    }
}
