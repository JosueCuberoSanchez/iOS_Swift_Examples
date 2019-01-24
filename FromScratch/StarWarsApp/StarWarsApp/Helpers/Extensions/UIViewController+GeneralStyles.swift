//
//  UIViewController+GeneralStyles.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    /**
     Sets up the detail view hierarchy.
     - Parameter scrollView: The scroll view that will go inside the parent view.
     - Parameter contentView: The content view that will go inside the scroll view.
     - Parameter backgroundImageView: The image view that will go inside the scroll view.
     */
    func setupViewHierarchy(_ scrollView: UIScrollView, _ contentView: UIView,
                            _ backgroundImageView: UIImageView) {

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

    }
}
