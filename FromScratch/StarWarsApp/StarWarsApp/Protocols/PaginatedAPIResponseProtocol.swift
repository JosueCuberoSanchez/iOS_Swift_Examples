//
//  PaginatedAPIResponseProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

/**
 Protocol for the SWAPI paginated response model
 */
protocol PaginatedAPIResponseProtocol: Codable {

    var count: Int {get set}
    var next: String? {get set}
    var previous: String? {get set}

}
