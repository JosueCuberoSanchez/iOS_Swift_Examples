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

        personImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(personImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)

        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.setTypography(.label)
        genderLabel.textAlignment = .center
        contentView.addSubview(genderLabel)

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.setTypography(.label)
        heightLabel.textAlignment = .center
        contentView.addSubview(heightLabel)

        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.setTypography(.label)
        homeworldLabel.textAlignment = .center
        contentView.addSubview(homeworldLabel)

        portraitImageViewTopAnchorConstraints = [
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 180)
        ]
        landscapeImageViewTopAnchorConstraints = [
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 50)
        ]

        updateDynamicViewConstraints()

        // Detail Image View
        NSLayoutConstraint.activate([
            personImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        // Name
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 50)
        ])

        // Gender
        NSLayoutConstraint.activate([
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
        ])

        // Height
        NSLayoutConstraint.activate([
            heightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heightLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 32)
        ])

        // Homeworld
        NSLayoutConstraint.activate([
            homeworldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            homeworldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            homeworldLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 32)
        ])

        // Testing image slider with collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "SliderCollectionViewCell")
        collectionView.collectionViewLayout.invalidateLayout()
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 300),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.topAnchor.constraint(equalTo: homeworldLabel.bottomAnchor, constant: 32)
        ])

        pagingControl.translatesAutoresizingMaskIntoConstraints = false
        pagingControl.numberOfPages = characterImages.count
        pagingControl.currentPage = 0
        pagingControl.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        pagingControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.addSubview(pagingControl)
        NSLayoutConstraint.activate([
            pagingControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pagingControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5)
        ])

        // Content view padding
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: pagingControl.bottomAnchor, constant: 50)
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
