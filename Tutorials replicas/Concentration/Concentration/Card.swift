//
//  Card.swift
//  Concentration
//
//  Created by Josue on 12/19/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    var seen = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUUID() -> Int {
        identifierFactory += 1
        return identifierFactory;
    }
    
    init() {
        self.identifier = Card.getUUID()
    }
    
}
