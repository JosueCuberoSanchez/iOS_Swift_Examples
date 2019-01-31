//
//  AuthenticationCoordinator.swift
//  StarWarsApp
//
//  Created by Josue on 1/30/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func coordinatorDidAuthenticate(coordinator: AuthenticationCoordinator)
}

final class AuthenticationCoordinator: Coordinator {

    var childCoordinators: [Coordinator]
    var viewController: LoginViewController
    weak var delegate: AuthenticationCoordinatorDelegate?

    init(from viewController: LoginViewController) {
        self.viewController = viewController
        childCoordinators = [Coordinator]()
    }

    func start() {
        showLoginViewController()
    }

    func showLoginViewController() {
        viewController.delegate = self
        // In a full programmatic way, I should present or show the VC here.
        // Also, if I would have to instantiate it here, I could inject it's VM.
    }

}

extension AuthenticationCoordinator: LoginViewControllerDelegate {

    func didSuccessfullyLogin() {
        delegate?.coordinatorDidAuthenticate(coordinator: self)
    }

}
