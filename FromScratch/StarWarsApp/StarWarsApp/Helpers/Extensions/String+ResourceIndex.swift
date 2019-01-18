//
//  String+Resource.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

extension String {
    
    var resourceIndex: Int? {
        guard let index = self.dropLast().components(separatedBy: "/").last else {
            return nil
        }
        return Int(index)
    }
    
}
