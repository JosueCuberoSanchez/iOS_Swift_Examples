//
//  Concentration.swift
//  Concentration
//
//  Created by Josue on 12/19/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    var flipCount = 0
    var score = 0
    private var indexOfSelectedCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairs: Int){
        assert(numberOfPairs > 0, "Concentration.init(\(numberOfPairs)): you must have at least one pair of cards.")
        for _ in 1 ... numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        //cards.shuffle();
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfSelectedCard, matchIndex != index {
                if(cards[matchIndex] == cards[index]) {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    checkForSeenCards(withMatchIndex: matchIndex, withIndex: index)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfSelectedCard = index
            }
        }
    }
    
    mutating private func checkForSeenCards(withMatchIndex matchIndex: Int, withIndex index: Int) {
        if cards[matchIndex].seen {
            score -= 1
        } else {
            cards[matchIndex].seen = true
        }
        if cards[index].seen {
            score -= 1
        } else {
            cards[matchIndex].seen = true
        }
        cards[index].isFaceUp = false
        cards[matchIndex].isFaceUp = false
    }
    
    mutating func reset() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].seen = false
        }
        indexOfSelectedCard = nil
        //cards.shuffle()
        score = 0
        flipCount = 0
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
