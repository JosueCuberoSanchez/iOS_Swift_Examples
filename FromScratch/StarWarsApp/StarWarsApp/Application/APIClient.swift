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
    
    private final let planetsPath = "planets/"
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    /**
     Creates and return an observable of type T based on the request response.
     
     - Parameter request: the URLRequest containing the url and the policy.
     - Returns: An observable of type T (ex: PeopleResponse)
     */
    private func requestAPIResource<T: Codable>(_ resource: Resource) -> Observable<T> {
        
        var finalResource = resource
        let request = finalResource.buildRequest()
        
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
     Gets an observable of the API response for the given resource.
     
     - Returns: An observable of type PeopleResponse, received from requestAPIResource.
     */
    func getResponse<T: Codable>(_ resource: Resource) -> (_ index: Int, _ requestType: Resource.RequestType) -> Observable<T> {
        return { index, requestType in
            var finalResource = resource
            finalResource.resourceIndex = index
            finalResource.requestType = requestType
            return self.requestAPIResource(finalResource)
        }
    }
    
}
