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

        /* For the effect of only-landscape scroll I had to use frames, 
         as constraints will always be updating and I don't want that.*/
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height+115)
        } else {
            scrollView.contentSize = CGSize(width: view.frame.size.height, height: view.frame.size.width+115)
        }
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view = scrollView

        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = #imageLiteral(resourceName: "backgroundImage")
        scrollView.addSubview(backgroundImageView)
        scrollView.sendSubviewToBack(backgroundImageView)

        // Background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])

        starshipImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(starshipImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        scrollView.addSubview(nameLabel)

        manufacturerLabel.translatesAutoresizingMaskIntoConstraints = false
        manufacturerLabel.setTypography(.label)
        scrollView.addSubview(manufacturerLabel)

        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthLabel.setTypography(.label)
        scrollView.addSubview(lengthLabel)

        passengersLabel.translatesAutoresizingMaskIntoConstraints = false
        passengersLabel.setTypography(.label)
        scrollView.addSubview(passengersLabel)

        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.setTypography(.label)
        scrollView.addSubview(classLabel)

        portraitImageViewTopAnchorConstraints = [
            starshipImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 145)
        ]
        landscapeImageViewTopAnchorConstraints = [
            starshipImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            starshipImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: starshipImageView.bottomAnchor, constant: 50)
            ])

        // Manufacturer
        NSLayoutConstraint.activate([
            manufacturerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            manufacturerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
            ])

        // Length
        NSLayoutConstraint.activate([
            lengthLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lengthLabel.topAnchor.constraint(equalTo: manufacturerLabel.bottomAnchor, constant: 32)
            ])

        // Passengers
        NSLayoutConstraint.activate([
            passengersLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passengersLabel.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 32)
            ])

        // Class
        NSLayoutConstraint.activate([
            classLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            classLabel.topAnchor.constraint(equalTo: passengersLabel.bottomAnchor, constant: 32)
            ])

    }

    override func viewDidLayoutSubviews() {
        scrollView.delegate = self // should be in this lifecycle method, else scroll will not work properly
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
