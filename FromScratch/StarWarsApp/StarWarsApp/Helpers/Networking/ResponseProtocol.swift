//
//  ResponseProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/21/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

protocol ResponseProtocol {
    associatedtype T
    func unwrapSuccess() throws -> T
    func unwrapError()-> NSError?
    var isSuccessful: Bool { get }
}
