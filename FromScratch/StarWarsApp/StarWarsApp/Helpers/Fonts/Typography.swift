//
//  Typography.swift
//  StarWarsApp
//
//  Created by Josue on 1/14/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

enum Typography {
    case label
}

extension Typography {
    
    var fontHeight: CGFloat  {
        switch self {
        case .label:
            return UIFont.labelFontSize
        }
    }
    
    var fontStyle: UIFont? {
        switch self {
        case .label:
            return R.font.starJediSpecialEdition(size: fontHeight)
        }
    }
    
}

extension UILabel {

    func setFontStyle(_ typography: Typography) {
        self.font = typography.fontStyle
        self.adjustsFontForContentSizeCategory = true
    }
    
}
