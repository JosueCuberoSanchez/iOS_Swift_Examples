//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Josue on 12/27/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGame" {
            if let cbc = segue.destination as? ConcentrationViewController {
                cbc.message = "Holi"
            } else {
            }
        }
    }

}
