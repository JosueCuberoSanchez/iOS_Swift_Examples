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
    case GET = "GET"
}

protocol ResourceProtocol {
    
    var path: String { get set }
    var index: Int? { get set }
    var fullResourcePath: String { get }
    var method: Method { get }
    var parameters: [String: String] { get }
    
}
