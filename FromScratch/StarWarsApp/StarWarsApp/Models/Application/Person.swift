//
//  Person.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Person: Codable {
    
    enum Gender: String, Codable {
        case male = "male"
        case female = "female"
        case notApplicable = "n/a"
    }
    
    let name: String
    let height: String
    let gender: Gender
    let homeworld: String
    
    init(name: String, height: String, gender: Gender, homeworld: String) {
        self.name = name
        self.height = height
        self.gender = gender
        self.homeworld = homeworld
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case gender = "gender"
        case homeworld = "homeworld"
    }
}

