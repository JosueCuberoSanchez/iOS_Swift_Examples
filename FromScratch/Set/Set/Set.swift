//
//  Set.swift
//  Set
//
//  Created by Josue on 12/21/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

struct Set {
    
    var numberOfCards = 24
    var numberOfVisibleCards = 12
    var numberOfSelectedCards = 0
    private(set) var cards = [Card]()
    private(set) var selectedIndices = [Int]()
    private var titles = ["▲","▲▲","▲▲▲","●","●●","●●●","■","■■","■■■"]
    
    init(){ createCards() }
    
    /**
     Creates the initial set of cards.
     */
    mutating func createCards() {
        for _ in 0 ..< numberOfVisibleCards {
            let card = Card(title: titles[Int(arc4random_uniform(9))],color: ColorEnum.randomColor(), texture: TextureEnum.randomTexture())
            cards += [card]
        }
        for _ in numberOfVisibleCards ..< numberOfCards {
            var card = Card(title: titles[Int(arc4random_uniform(9))],color: ColorEnum.randomColor(), texture: TextureEnum.randomTexture())
            card.inField = false
            cards += [card]
        }
    }
    
    /**
     Adds 3 more visible cards to the cards array.
     */
    mutating func dealMoreCards() {
        for index in numberOfVisibleCards ..< numberOfVisibleCards + 3 {
            cards[index].inField = true
        }
        numberOfVisibleCards += 3
    }
    
    /**
     Marks a card as selected.
     
     - Parameter index: The card index on the cards array
     */
    mutating func selectCardWithIndex(_ index: Int) {
        cards[index].selected = !cards[index].selected
        selectedIndices.append(index)
        numberOfSelectedCards += 1
    }
    
    /**
     Marks a card as disselected.
     
     - Parameter index: The card index on the cards array
     */
    mutating func diselectCardWithIndex(_ index: Int) {
        cards[index].selected = !cards[index].selected
        selectedIndices.removeAll(where: {$0 == index})
        numberOfSelectedCards -= 1
    }
    
    /**
     Checks if the selected cards make a valid set.
     
     - Returns true if it is a valid set, false othewise.
     */
    mutating func checkForSet() -> Bool {
        
        let card1 = cards[selectedIndices[0]]
        let card2 = cards[selectedIndices[1]]
        let card3 = cards[selectedIndices[2]]
        
        /// check for symbols
        if ((card1.title.prefix(1) == card2.title.prefix(1)) || (card1.title.prefix(1) == card3.title.prefix(1)) ||
            (card3.title.prefix(1) == card2.title.prefix(1)) ) {
            return false
        }
        
        /// check for number of symbols
        if ((card1.title.count == card2.title.count) || (card1.title.count == card3.title.count) ||
            (card3.title.count == card2.title.count) ) {
            return false
        }
        
        /// check for colors
        if ((card1.color == card2.color) || (card1.color == card3.color) ||
            (card3.color == card2.color) ) {
            return false
        }
        
        /// check for textures
        if ((card1.texture == card2.texture) || (card1.texture == card3.texture) ||
            (card3.texture == card2.texture) ) {
            return false
        }
        
        return true
    }   
    
    /**
     Removes the selected cards from the field.
    */
    mutating func removeCards(){
        for index in 0 ..< 3 {
            cards[selectedIndices[index]].selected = false
            cards[selectedIndices[index]].inField = false
        }
        numberOfSelectedCards = 0
        selectedIndices.removeAll()
    }
}
