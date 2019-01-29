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

    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    /**
     Creates and return an observable of type T based on the request response.
     
     - Parameter request: the URLRequest containing the url and the policy.
     - Returns: An observable of type T (ex: PeopleResponse)
     */
    func requestAPIResource<Value: Codable>(_ resource: ResourceProtocol) -> Observable<Response<Value>> {

        let request = buildRequest(resource)

        return Observable<Response<Value>>.create { [weak self] observer in

            guard let request = request else { // guard if the request is invalid
                observer.onNext(.failure(NetworkingError.invalidRequest))
                observer.onCompleted()
                return Disposables.create()
            }

            let task = self?.session.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    observer.onNext(.failure(NetworkingError.server(message: error.localizedDescription)))
                } else {

                    guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                        observer.onNext(.failure(NetworkingError.server(message: "Response objects are empty")))
                        observer.onCompleted()
                        return
                    }

                    do {
                        let model: Value = try JSONDecoder().decode(Value.self, from: data)
                        observer.onNext(.success(model, httpResponse.statusCode))
                    } catch {
                        observer.onNext(.failure(ApplicationError.decoding))
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
    func buildRequest(_ resource: ResourceProtocol) -> URLRequest? {

        guard let builtURL = URL(string: baseURL),
              var components = URLComponents(url: builtURL.appendingPathComponent(resource.path),
                                             resolvingAgainstBaseURL: false)
        else {
            return nil
        }

        if let parameters = resource.parameters {
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpShouldHandleCookies = false
        request.httpShouldUsePipelining = true
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if resource.method == .POST {
            guard let body = resource.body else {
                return nil
            }
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        return request
    }

}
