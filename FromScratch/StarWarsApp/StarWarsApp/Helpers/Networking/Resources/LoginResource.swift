//
//  LoginAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct LoginResource: ResourceProtocol {

    init(_ body: [String: Any]) {
        self.body = body
    }

    var path = "login/"
    var index: Int?

    var fullResourcePath: String {
        return path
    }

    var parameters: [String: String]?

    var method: Method {
        return .POST
    }

    var body: [String: Any]?

}
