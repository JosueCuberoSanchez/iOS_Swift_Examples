//
//  SpecieViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension SpecieViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        setupViewHierarchy(scrollView, contentView, backgroundImageView)

        specieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(specieImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)

        classificationLabel.translatesAutoresizingMaskIntoConstraints = false
        classificationLabel.setTypography(.label)
        classificationLabel.textAlignment = .center
        contentView.addSubview(classificationLabel)

        averageHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        averageHeightLabel.setTypography(.label)
        averageHeightLabel.textAlignment = .center
        contentView.addSubview(averageHeightLabel)

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.setTypography(.label)
        languageLabel.textAlignment = .center
        contentView.addSubview(languageLabel)

        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.setTypography(.label)
        homeworldLabel.textAlignment = .center
        contentView.addSubview(homeworldLabel)

        portraitImageViewTopAnchorConstraints = [
            specieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            specieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 145)
        ]
        landscapeImageViewTopAnchorConstraints = [
            specieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            specieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Name
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: specieImageView.bottomAnchor, constant: 50)
        ])

        // Classification
        NSLayoutConstraint.activate([
            classificationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classificationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            classificationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
        ])

        // AverageHeight
        NSLayoutConstraint.activate([
            averageHeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            averageHeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            averageHeightLabel.topAnchor.constraint(equalTo: classificationLabel.bottomAnchor, constant: 32)
        ])

        // Language
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            languageLabel.topAnchor.constraint(equalTo: averageHeightLabel.bottomAnchor, constant: 32)
        ])

        // Class
        NSLayoutConstraint.activate([
            homeworldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            homeworldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            homeworldLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 32)
        ])

        // Content view padding
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: homeworldLabel.bottomAnchor, constant: 50)
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
