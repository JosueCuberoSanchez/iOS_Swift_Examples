//
//  Response.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case error(Error)
}
