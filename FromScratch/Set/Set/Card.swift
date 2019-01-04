//
//  Card.swift
//  Set
//
//  Created by Josue on 12/21/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation


struct Card {
    
    var selected = false
    var inField = true
    var color: ColorEnum
    var texture: TextureEnum
    var title: String
    
    init(title: String, color: ColorEnum, texture: TextureEnum){
        self.title = title
        self.color = color
        self.texture = texture
    }

}
