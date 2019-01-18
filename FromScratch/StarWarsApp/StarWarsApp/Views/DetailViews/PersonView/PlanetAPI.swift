//
//  PlanetAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PlanetAPI: ResourceProtocol {
    
    init(_ index: Int) {
        self.index = index
    }
    
    var path = "planets/"
    var index: Int?
    
    var fullResourcePath: String {
        guard let index = index else {
            return path
        }
        return "\(path)\(String(index))"
    }
    
    var parameters: [String:String] = [:]
    
    var method: Method {
        return .GET
    }
    
}
