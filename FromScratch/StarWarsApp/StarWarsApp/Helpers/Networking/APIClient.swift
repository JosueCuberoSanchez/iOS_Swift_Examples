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
    
    enum Response<T> {
        case success(T)
        case error(Error)
    }
    
    private let session: URLSession
    var resource = Resource()
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    /**
     Sets the resource parameters.
     */
    func setResourceURLParameters(_ baseURL: String, _ path: String) {
        resource.baseURL = baseURL
        resource.path = path
    }
    
    /**
     Sets the resource full URL.
     */
    func setResourceFullURL(_ fullURL: String) {
        resource.fullURL = fullURL
    }
    
    /**
     Creates and return an observable of type T based on the request response.
     
     - Parameter request: the URLRequest containing the url and the policy.
     - Returns: An observable of type T (ex: PeopleResponse)
     */
    private func requestAPIResource<T: Codable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = self.session.dataTask(with: request) { (data, response, error) in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
                
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    /**
     Gets an observable of the API response for the people resource.
     
     - Returns: An observable of type PeopleResponse, received from requestAPIResource.
     */
    func getPeopleResponse() -> (_ page: Int) -> Observable<PeopleResponse> {
        return { page in
            var request: URLRequest;
            
            self.resource.page = page
            request = self.resource.buildRequestWithParameters()
            
            return self.requestAPIResource(request: request)
        }
    }
    
    /**
     Gets an observable of the API response for the planet resource.
     
     - Returns: An observable of type PlanetResponse, received from requestAPIResource.
     */
    func getPlanetResponse() -> (_ planetURL: String) -> Observable<PlanetResponse> {
        return { planetURL in
            var request: URLRequest;
            
            self.resource.fullURL = planetURL
            request = self.resource.buildRequestWithFullURL()
            
            return self.requestAPIResource(request: request)
        }
    }
    
}
