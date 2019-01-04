//
//  ColorEnum.swift
//  Set
//
//  Created by Josue on 12/21/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation

enum ColorEnum: UInt32{
    case green
    case purple
    case yellow

    /**
     Counts the number of elements of the enum.
     
     - Returns: The number of elements in the enum.
     */
    private static let _count: ColorEnum.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = ColorEnum(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    /**
     Searches a random value from the enum.
     
     - Returns: A random value of the enum.
     */
    static func randomColor() -> ColorEnum {
        let rand = arc4random_uniform(_count)
        return ColorEnum(rawValue: rand)!
    }
}
