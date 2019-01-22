//
//  PersonViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension StarshipViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        setupViewHierarchy(scrollView, contentView, backgroundImageView)

        starshipImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starshipImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)

        manufacturerLabel.translatesAutoresizingMaskIntoConstraints = false
        manufacturerLabel.setTypography(.label)
        manufacturerLabel.textAlignment = .center
        manufacturerLabel.numberOfLines = 2
        contentView.addSubview(manufacturerLabel)

        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthLabel.setTypography(.label)
        lengthLabel.textAlignment = .center
        contentView.addSubview(lengthLabel)

        passengersLabel.translatesAutoresizingMaskIntoConstraints = false
        passengersLabel.setTypography(.label)
        passengersLabel.textAlignment = .center
        contentView.addSubview(passengersLabel)

        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.setTypography(.label)
        classLabel.textAlignment = .center
        classLabel.numberOfLines = 2
        contentView.addSubview(classLabel)

        portraitImageViewTopAnchorConstraints = [
            starshipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 145)
        ]
        landscapeImageViewTopAnchorConstraints = [
            starshipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Name
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: starshipImageView.bottomAnchor, constant: 50)
        ])

        // Manufacturer
        NSLayoutConstraint.activate([
            manufacturerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            manufacturerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            manufacturerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
        ])

        // Length
        NSLayoutConstraint.activate([
            lengthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lengthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lengthLabel.topAnchor.constraint(equalTo: manufacturerLabel.bottomAnchor, constant: 32)
        ])

        // Passengers
        NSLayoutConstraint.activate([
            passengersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passengersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passengersLabel.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 32)
        ])

        // Class
        NSLayoutConstraint.activate([
            classLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            classLabel.topAnchor.constraint(equalTo: passengersLabel.bottomAnchor, constant: 32)
        ])

        // Content view padding
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 50)
        ])

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateDynamicViewConstraints()
    }

    /**
     Updates the dynamic views according to the current orientation.
     */
    func updateDynamicViewConstraints() {

        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.activate(landscapeImageViewTopAnchorConstraints)
            NSLayoutConstraint.deactivate(portraitImageViewTopAnchorConstraints)
            scrollView.isScrollEnabled = true
        } else {
            NSLayoutConstraint.activate(portraitImageViewTopAnchorConstraints)
            NSLayoutConstraint.deactivate(landscapeImageViewTopAnchorConstraints)
            scrollView.isScrollEnabled = false
        }

    }
}
