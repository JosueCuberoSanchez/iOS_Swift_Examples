//
//  ViewModelTypeProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

protocol ViewModelTypeProtocol {
    associatedtype Input
    associatedtype Output
    
    //func transform(input: Input) -> Output
}
