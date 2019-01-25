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
    var loginViewModel: LoginViewModel!

    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel =
            LoginViewModel(request: { self.apiClient.requestAPIResource(LoginAPI()) })
        setupBindings()
    }

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

        loginViewModel.loginFailure // leak
            .subscribe(onNext: { [weak self] error in
                print(error.debugDescription)
                self?.setErrorBordersForInputFields()
            })
            .disposed(by: disposeBag)

        loginViewModel.loginSuccess
            .subscribe(onNext: { [weak self] credentials in
                print("Welcome \(credentials.email)")
                self?.performSegue(withIdentifier: "seeTabBarViewSegue", sender: nil)
            })
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarViewController = segue.destination as? TabBarViewController {
            tabBarViewController.setAPIClient(apiClient: apiClient)
        }
    }

}

extension LoginViewController: APIClientInjectionProtocol {
    func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
