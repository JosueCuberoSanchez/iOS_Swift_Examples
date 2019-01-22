//
//  SpecieViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SpecieViewController: UIViewController, UIScrollViewDelegate {

    private var apiClient: APIClient!
    private var specieViewModel: SpecieViewModel!
    private let disposeBag = DisposeBag()

    // Subviews
    var scrollView = UIScrollView()
    var specieImageView = UIImageView(image: #imageLiteral(resourceName: "rebel-alliance"))
    var nameLabel = UILabel()
    var classificationLabel = UILabel()
    var averageHeightLabel = UILabel()
    var languageLabel = UILabel()
    var homeworldLabel = UILabel()
    var backgroundImageView = UIImageView()

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

    init(_ specie: Specie, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        specieViewModel =
            SpecieViewModel( request: { return self.apiClient.requestAPIResource(PlanetAPI($0)) }, specie: specie)
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
        specieViewModel.specieName
            .asObservable()
            .map { String(format: "\(R.string.localizable.nameLabel())%@", $0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Classification
        specieViewModel.specieClassification
            .asObservable()
            .map { String(format: "\(R.string.localizable.classificationLabel())%@", $0) }
            .bind(to: classificationLabel.rx.text)
            .disposed(by: disposeBag)

        /// Average height
        specieViewModel.specieAverageHeight
            .asObservable()
            .map { String(format: "\(R.string.localizable.averageHeightLabel())%@ ft", $0) }
            .bind(to: averageHeightLabel.rx.text)
            .disposed(by: disposeBag)

        /// Average height
        specieViewModel.specieLanguage
            .asObservable()
            .map { String(format: "\(R.string.localizable.languageLabel())%@", $0) }
            .bind(to: languageLabel.rx.text)
            .disposed(by: disposeBag)

        /// Homeworld
        specieViewModel.specieHomeworld
            .asObservable()
            .map { String(format: "\(R.string.localizable.homeworldLabel())%@", $0) }
            .bind(to: homeworldLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
