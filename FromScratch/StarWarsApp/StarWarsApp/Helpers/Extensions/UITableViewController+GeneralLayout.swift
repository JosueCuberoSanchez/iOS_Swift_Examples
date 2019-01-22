//
//  UITableViewController+CustomCell.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {

    /**
     Sets up the loading screen.
     */
    func setupLoadingScreen(_ loadingScreenView: LoadingScreenView) {

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
     - Parameter name: The name that will go on the nameLabel
     - Parameter detail: The detail that will go on the detailLabel
     */
    func customizeCell(_ cell: TableViewCell, _ row: Int, _ name: String, _ detail: String) {

        if row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.9639316307, green: 0.9639316307, blue: 0.9639316307, alpha: 1)
        }

        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.text = name
        cell.detailLabel.text = detail

    }

}
