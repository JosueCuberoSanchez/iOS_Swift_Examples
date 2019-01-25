//
//  LoginViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {

    // Inputs
    var email = PublishRelay<String>()
    var password = PublishRelay<String>()
    var loginTrigger = PublishRelay<Void>()

    var loginSuccess: Observable<Credentials>
    var loginFailure: Observable<Error?>

    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) { (email, password) in
            return Credentials(email: email, password: password)
        }
    }

    private var disposeBag = DisposeBag()

    init(request: @escaping () -> Observable<Response<LoginResponse>>) {
        loginSuccess = Observable.empty()
        loginFailure = Observable.empty()

        // Simulate the api call
        let sharedRequest = loginTrigger
            .withLatestFrom(credentialsObservable)
            .flatMapLatest { self.authenticateUser($0) }
            .share()

        let credentialsResponse = sharedRequest.mapSuccess()
        let errorResponse = sharedRequest.mapError()

        loginSuccess = credentialsResponse.map { $0 }
        loginFailure = errorResponse.map { $0 }
    }

    private func authenticateUser(_ credentials: Credentials) -> Observable<Response<Credentials>> {
        return Observable.create { observer in
            if credentials.email == "123" && credentials.password == "123" {
                observer.onNext(.success(credentials))
            } else {
                observer.onNext(.failure(ApplicationError.invalidCredentials))
            }
            return Disposables.create()
        }
    }

}
