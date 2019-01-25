//
//  LoginViewController+Layout.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {

    // swiftlint:disable:next function_body_length
    override func loadView() {
        super.loadView()

        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = #imageLiteral(resourceName: "dark-side")
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        // Background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.alpha = 0.7
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        //Stack View
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Logo view
        let logoView = UIImageView()
        logoView.image = #imageLiteral(resourceName: "logo")

        // Email views
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.setTypography(.label)
        emailLabel.text = "Email"
        emailLabel.textAlignment = .left
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter email"
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        emailTextField.borderStyle = .roundedRect

        let emailView = UIView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailView.addSubview(emailLabel)
        emailView.addSubview(emailTextField)

        // Password views
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.setTypography(.label)
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        passwordTextField.borderStyle = .roundedRect

        let passwordView = UIView()
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.addSubview(passwordLabel)
        passwordView.addSubview(passwordTextField)

        // Button
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.setTypography(.label)
        loginButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        loginButton.titleEdgeInsets.left = 5
        loginButton.titleEdgeInsets.right = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        // Add views
        stackView.addArrangedSubview(logoView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(loginButton)

        // Logo view constraints
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 200),
            logoView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // Email view constraints
        NSLayoutConstraint.activate([
            emailView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            emailView.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalTo: emailView.widthAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5)
        ])

        // Password view constraints
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalTo: passwordView.widthAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([
            passwordView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 70)
        ])

        // Login button constraints
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setErrorBordersForInputFields() {
        emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }

}
