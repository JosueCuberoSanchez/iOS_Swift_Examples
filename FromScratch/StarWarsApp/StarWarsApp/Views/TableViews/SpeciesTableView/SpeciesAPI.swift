//
//  SpeciesAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct SpeciesAPI: ResourceProtocol {

    init(_ index: Int) {
        self.index = index
    }

    var path = "species/"
    var index: Int?

    var fullResourcePath: String {
        return path
    }

    var parameters: [String: String] {
        guard let index = index else {
            return [:]
        }
        return ["page": String(index)]
    }

    var method: Method {
        return .GET
    }

}
