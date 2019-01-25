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
    private var baseURL = "https://swapi.co/api/"

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }

    /**
     Creates and return an observable of type T based on the request response.
     
     - Parameter request: the URLRequest containing the url and the policy.
     - Returns: An observable of type T (ex: PeopleResponse)
     */
    func requestAPIResource<Value: Codable>(_ resource: ResourceProtocol) -> Observable<Response<Value>> {

        var request: URLRequest
        do {
            request = try buildRequest(resource)
        } catch let error {
            print(error)
            return Observable.empty()
        }

        return Observable<Response<Value>>.create { [weak self] observer in

            let task = self?.session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onNext(.failure(ApplicationError.server(message: error.localizedDescription)))
                } else {

                    guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                        observer.onNext(.failure(ApplicationError.server(message: "Response object is empty")))
                        return
                    }

                    if 200 ... 299 ~= httpResponse.statusCode {
                        do {
                            let model: Value = try JSONDecoder().decode(Value.self, from: data)
                            observer.onNext(.success(model))
                        } catch {
                            print(error)
                            observer.onNext(.failure(ApplicationError.decoding))
                        }
                    } else {
                        observer.onNext(.failure(ApplicationError.badStatusCode(statusCode: httpResponse.statusCode)))
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

        // this will be just to test post...
        // comparing resource path, because I may use post method to log in into a real auth server...
        if resource.fullResourcePath == "posts/" {
            baseURL = "https://jsonplaceholder.typicode.com"
        }

        guard let builtURL = URL(string: baseURL) else {
            throw ApplicationError.invalidURL(url: baseURL)
        }

        guard var components =
            URLComponents(url: builtURL.appendingPathComponent(resource.fullResourcePath),
                          resolvingAgainstBaseURL: false) else {
            throw ApplicationError.invalidURL(url: baseURL+resource.fullResourcePath)
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
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // this is just to test post
        if resource.fullResourcePath == "posts/" {
            let parameters: [String: Any] = ["title": "Title", "body": "Body", "userId": 1]
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }

}
