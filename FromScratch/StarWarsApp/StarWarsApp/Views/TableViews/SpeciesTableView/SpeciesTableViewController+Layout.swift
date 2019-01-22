//
//  SpeciesTableViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension SpeciesTableViewController {

    /**
     Sets up the loading screen.
     */
    func setupLoadingScreen() {

        view.addSubview(loadingScreenView)

        NSLayoutConstraint.activate([
            loadingScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingScreenView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

    }

    /**
     Customize each PersonCell with the corresponding data and style
     - Parameter cell: The cell that will be modified
     - Parameter row: The cell row number
     - Parameter specieName: The specie name that will go on the cell specieNameLabel
     - Parameter specieClassification: The specie classification that will go on the cell specieClassificationLabel
     */
    func customizeSpeciesCell(_ cell: SpeciesTableViewCell, _ row: Int,
                              _ specieName: String, _ specieClassification: String) {

        if row % 2 == 0 {
            cell.backgroundColor = UIConstants.evenCellColor
        } else {
            cell.backgroundColor = UIConstants.oddCellColor
        }

        cell.accessoryType = .disclosureIndicator
        cell.specieNameLabel.text = specieName
        cell.specieClassificationLabel.text = specieClassification

    }
}
