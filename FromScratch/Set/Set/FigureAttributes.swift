//
//  FigureAttributes.swift
//  Set
//
//  Created by Josue on 12/21/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import Foundation
import UIKit

struct FigureAttributes {
    /// NSA String Attributes for the different figure textures
    static let fullGreenFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.green ]
    static let fullPurpleFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.purple ]
    static let fullYellowFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.yellow ]
    static let degradedGreenFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.green.withAlphaComponent(0.5) ]
    static let degradedPurpleFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.purple.withAlphaComponent(0.5) ]
    static let degradedYellowFigureAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor : UIColor.yellow.withAlphaComponent(0.5) ]
    static let greenBorderedFigureAttributes: [NSAttributedString.Key: Any] = [ .strokeWidth: 4, .strokeColor : UIColor.green, .foregroundColor : UIColor.white ]
    static let purpleBorderedFigureAttributes: [NSAttributedString.Key: Any] = [ .strokeWidth: 4, .strokeColor : UIColor.purple, .foregroundColor : UIColor.white ]
    static let yellowBorderedFigureAttributes: [NSAttributedString.Key: Any] = [ .strokeWidth: 4, .strokeColor : UIColor.yellow, .foregroundColor : UIColor.white ]
}
