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
        case hermaphrodite = "hermaphrodite"
        case none = "none"
    }
    
    let height: String
    let homeworld: String
    let name: String
    let gender: Gender
    
}

