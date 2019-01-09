//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

struct ResourceAPI: Resource {
    
    var fullURL: String?
    var baseURL: String?
    var path: String?
    var page: Int?
    
    var parameters: [String: String] {
        return [NetworkingConstants.PAGE_PARAMETER_NAME:String(page!)]
    }
    
    /**
     Interface for Resource resourceRequestWithParameters method.
     
     - Returns: The built URL request.
     */
    func resourceRequestWithParameters() -> URLRequest {
        return buildRequestWithParameters()
    }
    
    /**
     Interface for Resource resourceRequestWithFullURL method.
     
     - Returns: The built URL request.
     */
    func resourceRequestWithFullURL() -> URLRequest {
        return buildRequestWithFullURL()
    }
}
