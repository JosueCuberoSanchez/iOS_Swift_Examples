//
//  TextFieldCollectionViewCell.swift
//  EmojiArt
//
//  Created by Josue on 1/3/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resignationHandler: (() -> Void)?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // hide keyboard on return press
        return true
    }
}
