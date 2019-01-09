//
//  Constants.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    // API Routes
    static let BASE_URL = "https://swapi.co/api/"
    static let PEOPLE_URL = "people/"
    static let STARSHIPS_URL = "starships/"
    static let SPECIES_URL = "species/"
    
    // Variable names
    static let PAGE_PARAMETER_NAME = "page"
    
    // Resource consuming options
    static let ACCEPT = "accept"
    
    // Resource types
    static let APPLICATION_JSON = "application/json"
}
