//
//  PeopleTableViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension PeopleTableViewController {

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
     - Parameter personName: The person name that will go on the cell personNameLabel
     - Parameter personGender: The person gender that will go on the cell personGenderLabel
     */
    func customizePersonCell(_ cell: PeopleTableViewCell, _ row: Int, _ personName: String, _ personGender: String) {

        if row % 2 == 0 {
            cell.backgroundColor = UIConstants.evenCellColor
        } else {
            cell.backgroundColor = UIConstants.oddCellColor
        }

        cell.accessoryType = .disclosureIndicator
        cell.personNameLabel.text = personName
        cell.personGenderLabel.text = personGender

    }
}
