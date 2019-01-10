//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

struct Resource: ResourceProtocol {
    
    var requestURL: RequestURL?
    var fullURL: String?
    var baseURL: String?
    var path: String?
    var page: Int?
    
    // computed attributes
    var parameters: [String: String] { return [NetworkingConstants.PAGE_PARAMETER_NAME:String(page!)] }
    var method: Method { return .GET }
    
    /**
     Builds a URLRequest based on a baseURL, path and parameters.
     
     - Returns: The built URL request.
     */
    func buildRequestWithParameters() -> URLRequest {
        
        guard let baseURL = URL(string: baseURL!) else {
            fatalError(ErrorMessageConstants.BASE_URL_ERROR)
        }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path!), resolvingAgainstBaseURL: false) else {
            fatalError(ErrorMessageConstants.URL_COMPONENTS_ERROR)
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError(ErrorMessageConstants.URL_ERROR)
        }
        
        return buildURLRequest(url)
    }
    
    /**
     Builds a URLRequest based on just a full URL of the resource.
     
     - Returns: The built URL request.
     */
    func buildRequestWithFullURL() -> URLRequest {
        
        guard let fullURL = URL(string: fullURL!) else {
            fatalError(ErrorMessageConstants.BASE_URL_ERROR)
        }
        
        return buildURLRequest(fullURL)
    }
    
    /**
     Builds a URLRequest based on a URL and the header values.
     
     - Returns: The built URL request.
     */
    private func buildURLRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(NetworkingConstants.APPLICATION_JSON, forHTTPHeaderField: NetworkingConstants.ACCEPT)
        return request
    }
    
}
