//
//  ResponseProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/21/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

protocol ResponseProtocol {
    associatedtype Value
    func unwrapSuccess() throws -> Value
    func unwrapError() -> Error?
    var isSuccessful: Bool { get }
}
