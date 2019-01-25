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
     Injects the apiClient to each child view.
     */
    func setAPIClient(apiClient: APIClient) {
        for child in viewControllers ?? [] {
            for nav in child.children {
                if let top = nav as? APIClientInjectionProtocol {
                    top.setAPIClient(apiClient: apiClient)
                }
            }
        }
    }

}
