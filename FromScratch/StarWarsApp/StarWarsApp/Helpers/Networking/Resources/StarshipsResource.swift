//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct StarshipsResource: ResourceProtocol {

    init(_ index: Int) {
        self.index = index
    }

    var path = "starships/"
    var index: Int?

    var fullResourcePath: String {
        return path
    }

    var parameters: [String: String]? {
        guard let index = index else {
            return nil
        }
        return ["page": String(index)]
    }

    var method: Method {
        return .GET
    }

    var body: [String: Any]?

}