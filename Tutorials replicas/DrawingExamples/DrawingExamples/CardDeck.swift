//
//  CardDeck.swift
//  DrawingExamples
//
//  Created by Josue on 12/26/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

struct CardDeck {
    
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in Suit.all {
            for rank in Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
        cards.shuffle()
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
