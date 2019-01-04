//
//  TitleEnum.swift
//  Set
//
//  Created by Josue on 12/21/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

enum TitleEnum: UInt32 {
    case singleTriangle 
    case doubleTriangle
    case tripleTriangle
    case singleSquare
    case doubleSquare
    case tripleSquare
    case singleCircle
    case doubleCircle
    case tripleCircle
    
    private static let _count: TitleEnum.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = TitleEnum(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomTitle() -> TitleEnum {
        let rand = arc4random_uniform(_count)
        return TitleEnum(rawValue: rand)!
    }
}
