//
//  TabBarView.swift
//  StarWarsApp
//
//  Created by Josue on 1/24/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    /**
     Injects the needed dependencies to each child view.
     */
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        for child in viewControllers ?? [] {
            for nav in child.children {
                if let top = nav as? DependenciesInjection {
                    top.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder)
                }
            }
        }
    }

}
