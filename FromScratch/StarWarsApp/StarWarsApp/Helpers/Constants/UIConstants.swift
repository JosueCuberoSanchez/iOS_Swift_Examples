//
//  UIConstants.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

struct UIConstants {
    
    // Colors
    static let EVEN_CELL_COLOR = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let ODD_CELL_COLOR = #colorLiteral(red: 0.9639316307, green: 0.9639316307, blue: 0.9639316307, alpha: 1)
    
    // Table cells identifiers
    static let PERSON_CELL_IDENTIFIER = "PersonCell"
    
    // Segue IDs
    static let SEE_PERSON_DETAILS_SEGUE_IDENTIFIER = "seePersonDetailsSegue"
    
    // UI Messages
    static let LOADING = "Loading..."

    // Loading screen view sizes
    static let FRAME_WIDTH: CGFloat = 120
    static let FRAME_HEIGTH: CGFloat = 30
    static let FRAME_DIVISOR: CGFloat = 2
    static let INITIAL_FRAME_ORIGIN = 0
    static let FRAME_ORIGIN = 695
    static let SPINNER_WIDTH = 30
    static let SPINNER_HEIGHT = 30
    static let LOADING_LABEL_WIDTH = 140
    static let LOADING_LABEL_HEIGHT = 30
    
    // Label texts
    static let NAME_LABEL = "Name: "
    static let GENDER_LABEL = "Gender: "
    static let HEIGHT_LABEL = "Height: "
    static let HOMEWORLD_LABEL = "Homeworld: "
    
    // Font names
    static let STAR_JEDI_SPECIAL_EDITION_FONT_NAME = "StarJediSpecialEdition"
    
    // Image names
    static let BACKGROUND_IMAGE_NAME = "background"
    
    // Image alphas
    static let BACKGROUND_IMAGE_ALPHA: CGFloat = 0.5
}
