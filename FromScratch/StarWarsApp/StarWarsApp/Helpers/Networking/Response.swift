//
//  Response.swift
//  StarWarsApp
//
//  Created by Josue on 1/16/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum Response<T> {
    case Success(T)
    case Failure(NSError)
}

extension Response {
    func unwrap() throws -> T {
        switch self {
            case .Success(let value):
                return value
            case .Failure(let error):
                throw error
        }
    }
}
