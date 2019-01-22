//
//  PeopleTableViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension StarshipsTableViewController {

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
     - Parameter starshipName: The starship name that will go on the cell starshipNameLabel
     - Parameter starshipManufacturer: The starship manufacturer that will go on the cell starshipManufacturerLabel
     */
    func customizeStarshipCell(_ cell: StarshipsTableViewCell, _ row: Int,
                               _ starshipName: String, _ starshipManufacturer: String) {

        if row % 2 == 0 {
            cell.backgroundColor = UIConstants.evenCellColor
        } else {
            cell.backgroundColor = UIConstants.oddCellColor
        }

        cell.accessoryType = .disclosureIndicator
        cell.starshipNameLabel.text = starshipName
        cell.starshipManufacturerLabel.text = starshipManufacturer

    }
}
