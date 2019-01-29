//
//  PlanetAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PlanetResource: ResourceProtocol {

    init(_ path: String) {
        self.path = path
    }

    var path: String
    var index: Int?
    var parameters: [String: String]?
    var method: Method {
        return .GET
    }
    var body: [String: Any]?

}
