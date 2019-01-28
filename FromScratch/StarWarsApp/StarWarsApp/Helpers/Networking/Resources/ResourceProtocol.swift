//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

enum Method: String {
    case GET
    case POST
}

protocol ResourceProtocol {

    var path: String { get }
    var index: Int? { get }
    var fullResourcePath: String { get }
    var method: Method { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }

}
