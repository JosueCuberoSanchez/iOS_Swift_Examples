//
//  Resource.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
}

enum RequestURL {
    case FULL_URL
    case CUSTOM_URL
}

protocol ResourceProtocol {
    var method: Method { get }
    var requestURL: RequestURL? { get }
    var path: String? { get }
    var parameters: [String: String] { get }
    var baseURL: String? { get }
    var fullURL: String? { get }
}
