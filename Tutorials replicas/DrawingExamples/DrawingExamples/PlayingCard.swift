//
//  PlayingCard.swift
//  DrawingExamples
//
//  Created by Josue on 12/26/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var description: String { return "\(rank) \(suit)" }
    
    var suit: Suit
    var rank: Rank
}
