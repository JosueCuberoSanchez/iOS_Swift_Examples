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
    var resourceAPI = ResourceAPI()
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
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
    
}

extension APIClient { /// This extension will be for all of the custom requests (ex: getPeople, getStarships, getSpecies)
    
    /**
     Gets an observable of the API response for the people resource.
     
     - Returns: An observable of type PeopleResponse, received from requestAPIResource.
     */
    var getPeopleResponse: () -> Observable<PeopleResponse> {
        return {
            let request = self.resourceAPI.buildRequestWithParameters()
            return self.requestAPIResource(request: request)
        }
    }

}
