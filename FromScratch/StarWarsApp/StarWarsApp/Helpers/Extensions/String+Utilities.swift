//
//  String+Resource.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

extension String {

    /**
     Gets the index of a url resource. Ex: https://swapi.com/planets/12 -> 12
     */
    var resourceIndex: Int? {
        guard let index = self.dropLast().components(separatedBy: "/").last else {
            return nil
        }
        return Int(index)
    }

}
