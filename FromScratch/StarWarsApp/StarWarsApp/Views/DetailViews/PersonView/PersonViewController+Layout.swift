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
    
    override func loadView() {
        super.loadView()
        
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: view.frame.size.height, height: view.frame.size.width)
        }
        view = scrollView
        
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(personImageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setTypography(.label)
        view.addSubview(nameLabel)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.setTypography(.label)
        view.addSubview(genderLabel)
        
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.setTypography(.label)
        view.addSubview(heightLabel)
        
        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.setTypography(.label)
        view.addSubview(homeworldLabel)
        
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = #imageLiteral(resourceName: "backgroundImage")
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        portraitImageViewTopAnchorConstraints = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 180),
        ]
        landscapeImageViewTopAnchorConstraints = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 30),
        ]
        
        updateDynamicViewConstraints()
        
        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 50),
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
        
        // Background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
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
