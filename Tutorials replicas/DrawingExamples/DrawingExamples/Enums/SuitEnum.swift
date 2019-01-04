//
//  SuitEnum.swift
//  DrawingExamples
//
//  Created by Josue on 12/26/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

enum Suit: String, CustomStringConvertible {
    
    case spades = "♠"
    case hearts = "❤️"
    case diamonds = "♣"
    case clubs = "♦"
    
    static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    
    var description: String { return rawValue }
}
