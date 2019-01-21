//
//  PersonViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PersonViewController: UIViewController, UIScrollViewDelegate {
    
    
    private var apiClient: APIClient!
    private var personViewModel: PersonViewModel!
    private let disposeBag = DisposeBag()
    
    // Subviews
    var scrollView = UIScrollView()
    var personImageView = UIImageView(image: #imageLiteral(resourceName: "bb8"))
    var nameLabel = UILabel()
    var genderLabel = UILabel()
    var heightLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()
    
    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    
    init(_ person: Person, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        personViewModel = PersonViewModel( request: { return self.apiClient.requestAPIResource(PlanetAPI($0)) }, person: person)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NS Coder init fatal error.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    /**
     Bind the subviews data to the viewModel's behaviour relays.
     */
    private func setupBindings() {
        /// Name
        personViewModel.personName
            .asObservable()
            .map { String(format: "\(R.string.localizable.nameLabel())%@", $0) }
            .bind(to:nameLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Gender
        personViewModel.personGender
            .asObservable()
            .map { String(format: "\(R.string.localizable.genderLabel())%@", $0) }
            .bind(to:genderLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Height
        personViewModel.personHeight
            .asObservable()
            .map { String(format: "\(R.string.localizable.heightLabel())%@", $0) }
            .bind(to:heightLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Homeworld
        personViewModel.personHomeworld
            .asObservable()
            .map { String(format: "\(R.string.localizable.homeworldLabel())%@", $0) }
            .bind(to:homeworldLabel.rx.text)
            .disposed(by:disposeBag)
    }

}
