//
//  APIResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

/**
 Protocol for the SWAPI response model
 */
protocol APIResponseProtocol: Codable {
    
    var count: Int {get set}
    var next: String? {get set}
    var previous: String? {get set}
    
}

