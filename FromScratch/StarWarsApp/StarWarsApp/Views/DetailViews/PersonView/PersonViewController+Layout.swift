//
//  PersonViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension PersonViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        /* For the effect of only-landscape scroll I had to use frames, 
        as constraints will always be updating and I don't want that.*/
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: view.frame.size.height, height: view.frame.size.width)
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

        personImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(personImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        scrollView.addSubview(nameLabel)

        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.setTypography(.label)
        scrollView.addSubview(genderLabel)

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.setTypography(.label)
        scrollView.addSubview(heightLabel)

        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.setTypography(.label)
        scrollView.addSubview(homeworldLabel)

        portraitImageViewTopAnchorConstraints = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 180)
        ]
        landscapeImageViewTopAnchorConstraints = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 50)
        ])

        // Gender
        NSLayoutConstraint.activate([
            genderLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
        ])

        // Height
        NSLayoutConstraint.activate([
            heightLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            heightLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 32)
        ])

        // Homeworld
        NSLayoutConstraint.activate([
            homeworldLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            homeworldLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 32)
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
