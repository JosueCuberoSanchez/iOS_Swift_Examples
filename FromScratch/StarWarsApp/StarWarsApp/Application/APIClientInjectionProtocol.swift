//
//  APIClientInyectionProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/17/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

/**
  This protocol is for those classes that need the apiClient to be injected.
 */
protocol APIClientInjectionProtocol {
    func setAPIClient(apiClient: APIClient)
}
