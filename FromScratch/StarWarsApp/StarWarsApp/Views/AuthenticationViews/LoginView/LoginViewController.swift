//
//  LoginViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    var apiClient: APIClient!
    var jsonDecoder: JSONDecoder!
    var loginViewModel: LoginViewModel!

    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel =
            LoginViewModel(request: { LoginResource($0).execute(with: self.apiClient, using: self.jsonDecoder) })
        setupBindings()
    }

    /**
     Binds the inputs, button and login response.
     */
    private func setupBindings() {
        emailTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.email.accept($0)
            })
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.password.accept($0)
            })
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.loginTrigger.accept(())
            })
            .disposed(by: disposeBag)

        loginViewModel.loginFailure
            .drive(onNext: { [weak self] error in
                print(error.debugDescription)
                self?.setErrorBordersForInputFields()
            })
            .disposed(by: disposeBag)

        loginViewModel.loginSuccess
            .drive(onNext: { [weak self] user in
                print("Welcome \(user.firstName) \(user.lastName)")
                self?.performSegue(withIdentifier: "seeTabBarViewSegue", sender: nil)
            })
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarViewController = segue.destination as? TabBarViewController {
            tabBarViewController.setDependencies(apiClient: APIClient(baseURL: "https://swapi.co/api/"),
                                                 jsonDecoder: jsonDecoder)
        }
    }

}

extension LoginViewController: DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        self.apiClient = apiClient
        self.jsonDecoder = jsonDecoder
    }
}
