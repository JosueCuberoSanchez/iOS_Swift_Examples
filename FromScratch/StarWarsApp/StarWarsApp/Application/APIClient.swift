//
//  APIClient.swift
//  StarWarsApp
//
//  Created by Josue on 1/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

final class APIClient {
    
    private let session: URLSession
    private final let baseURL = "https://swapi.co/api/"
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    /**
     Creates and return an observable of type T based on the request response.
     
     - Parameter request: the URLRequest containing the url and the policy.
     - Returns: An observable of type T (ex: PeopleResponse)
     */
    func requestAPIResource<T: Codable>(_ resource: ResourceProtocol) -> Observable<Response<T>> {
        
        var request: URLRequest
        do {
            request = try buildRequest(resource)
        } catch(let error) {
            print(error)
            return Observable.empty()
        }
        
        
        
        return Observable<Response<T>>.create { [weak self] observer in
            
            let task = self?.session.dataTask(with: request) { (data, response, error) in
                print(request.url)
                if let error = error {
                    observer.onNext(.failure(ApplicationError.server(message: error.localizedDescription) as NSError))
                } else {
                    guard let data = data else {
                        return
                    }
                    
                    do {
                        let model: T = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(.success(model))
                    } catch {
                        observer.onNext(.failure(ApplicationError.decoding as NSError))
                    }
                }
                observer.onCompleted()
            }
            
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    /**
     Builds a URLRequest based on a baseURL, path and parameters.
     
     - Returns: The built URL request.
     */
    func buildRequest(_ resource: ResourceProtocol) throws -> URLRequest {
        
        guard let baseURL = URL(string: baseURL) else {
            throw ApplicationError.invalidURL(url: self.baseURL)
        }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(resource.fullResourcePath), resolvingAgainstBaseURL: false) else {
            throw ApplicationError.invalidURL(url: self.baseURL+resource.fullResourcePath)
        }
        
        let parameters = resource.parameters
        if parameters != [:] {
            components.queryItems = parameters.map {
                URLQueryItem(name: String($0), value: String($1))
            }
        }
        
        guard let url = components.url else {
            throw ApplicationError.invalidURLComponents
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpShouldHandleCookies = false
        request.httpShouldUsePipelining = true
        request.addValue("application/json", forHTTPHeaderField: "accept")
        return request
    }
    
}
