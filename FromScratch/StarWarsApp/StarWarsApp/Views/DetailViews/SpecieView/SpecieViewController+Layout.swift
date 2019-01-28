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

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        scrollView.addSubview(backgroundImageView)
        scrollView.sendSubviewToBack(backgroundImageView)

        // Background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

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
            specieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 145)
        ]
        landscapeImageViewTopAnchorConstraints = [
            specieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Detail Image View
        NSLayoutConstraint.activate([
            specieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

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
        } else {
            NSLayoutConstraint.activate(portraitImageViewTopAnchorConstraints)
            NSLayoutConstraint.deactivate(landscapeImageViewTopAnchorConstraints)
        }

    }
}
