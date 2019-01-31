//
//  APIClientInyectionProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/17/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

/**
  This protocol is for those classes that need the dependencies to be injected.
 */
protocol DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder, delegate: TabBarControllerDelegate?)
}
