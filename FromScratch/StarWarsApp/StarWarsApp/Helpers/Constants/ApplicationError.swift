//
//  ExceptionEnum.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum ApplicationError: Error {
    case invalidURL(url: String)
    case invalidURLComponents
    case invalidRequest
    case server(message: String)
    case badStatusCode(statusCode: Int)
    case decoding
}
