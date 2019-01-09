//
//  String+Beautifiers.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Capitalized the first letter on a String.
     
     - Returns: The modified String.
     */
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
