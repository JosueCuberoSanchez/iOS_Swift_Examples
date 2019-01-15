//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

struct Resource {
    
    enum Method: String {
        case GET = "GET"
    }
    
    enum RequestType {
        case parametrized
        case nonParametrized
    }
    
    let baseURL = "https://swapi.co/api/"
    var resourcePath: String?
    var resourceIndex: Int?
    var requestType: RequestType?
    
    
    private let pageParameterName = "page"
    private let acceptHeader = "accept"
    private let applicationJSON = "application/json"

    // computed attributes
    var parameters: [String: String] { return [pageParameterName:String(resourceIndex!)] }
    var method: Method { return .GET }
    
    init(_ resourcePath: String) {
        self.resourcePath = resourcePath
    }
    
    /**
     Builds a URLRequest based on a baseURL, path and parameters.
     
     - Returns: The built URL request.
     */
    mutating func buildRequest() -> URLRequest {
        
        guard let baseURL = URL(string: baseURL) else {
            fatalError(ErrorsEnum.baseURLError.rawValue)
        }
        
        if requestType == RequestType.nonParametrized {
            resourcePath = resourcePath! + String(resourceIndex!)
        }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(resourcePath!), resolvingAgainstBaseURL: false) else {
            fatalError(ErrorsEnum.URLComponentsError.rawValue)
        }
        
        if requestType == RequestType.parametrized {
            components.queryItems = parameters.map {
                URLQueryItem(name: String($0), value: String($1))
            }
        }
        
        guard let url = components.url else {
            fatalError(ErrorsEnum.URLError.rawValue)
        }
        
        return buildURLRequest(url)
    }
    
    /**
     Builds a URLRequest based on a URL and the header values.
     
     - Returns: The built URL request.
     */
    private func buildURLRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(applicationJSON, forHTTPHeaderField: acceptHeader)
        return request
    }
    
}
