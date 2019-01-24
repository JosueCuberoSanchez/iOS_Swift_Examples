//
//  PostAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/24/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PostAPI: ResourceProtocol {

    var path = "posts/"
    var index: Int?

    var fullResourcePath: String {
        return path
    }

    var parameters: [String: String] = [:]

    var method: Method {
        return .POST
    }

}
