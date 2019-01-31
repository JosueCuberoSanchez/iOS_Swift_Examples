//
//  TabBarView.swift
//  StarWarsApp
//
//  Created by Josue on 1/24/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarControllerDelegate: class {
    func didTapOnPersonRow(of person: Person,
                           using navigationController: UINavigationController)
    func didTapOnStarshipRow(of starship: Starship,
                             using navigationController: UINavigationController)
    func didTapOnSpecieRow(of specie: Specie,
                           using navigationController: UINavigationController)
}

class TabBarViewController: UITabBarController {

    weak var customDelegate: TabBarControllerDelegate?

}

extension TabBarViewController: DependenciesInjection {

    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder, delegate: TabBarControllerDelegate?) {
        self.customDelegate = delegate
        for child in viewControllers ?? [] {
            for nav in child.children {
                if let top = nav as? DependenciesInjection {
                    top.setDependencies(apiClient: apiClient,
                                        jsonDecoder: jsonDecoder,
                                        delegate: customDelegate)
                }
            }
        }
    }

}
