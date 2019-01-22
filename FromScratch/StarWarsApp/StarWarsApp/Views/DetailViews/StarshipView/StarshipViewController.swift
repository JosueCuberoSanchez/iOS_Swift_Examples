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

class StarshipViewController: UIViewController, UIScrollViewDelegate {

    private var apiClient: APIClient!
    private var starshipViewModel: StarshipViewModel!
    private let disposeBag = DisposeBag()

    // Subviews
    var scrollView = UIScrollView()
    var contentView = UIView()
    var starshipImageView = UIImageView(image: #imageLiteral(resourceName: "death-star-d"))
    var nameLabel = UILabel()
    var manufacturerLabel = UILabel()
    var lengthLabel = UILabel()
    var passengersLabel = UILabel()
    var classLabel = UILabel()
    var backgroundImageView = UIImageView()

    // Dynamic constraints
    var portraitImageViewTopAnchorConstraints: [NSLayoutConstraint]!
    var landscapeImageViewTopAnchorConstraints: [NSLayoutConstraint]!

    init(_ starship: Starship, _ apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
        starshipViewModel = StarshipViewModel(starship: starship)
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
        starshipViewModel.starshipName
            .asObservable()
            .map { String(format: "\(R.string.localizable.nameLabel())%@", $0) }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)

        /// Manufacturer
        starshipViewModel.starshipManufacturer
            .asObservable()
            .map { String(format: "\(R.string.localizable.manufacturerLabel())%@", $0) }
            .bind(to: manufacturerLabel.rx.text)
            .disposed(by: disposeBag)

        /// Length
        starshipViewModel.starshipLength
            .asObservable()
            .map { String(format: "\(R.string.localizable.lengthLabel())%@ ft", $0) }
            .bind(to: lengthLabel.rx.text)
            .disposed(by: disposeBag)

        /// Passengers
        starshipViewModel.starshipPassengers
            .asObservable()
            .map { String(format: "\(R.string.localizable.passengersLabel())%@", $0) }
            .bind(to: passengersLabel.rx.text)
            .disposed(by: disposeBag)

        /// Class
        starshipViewModel.starshipClass
            .asObservable()
            .map { String(format: "\(R.string.localizable.classLabel())%@", $0) }
            .bind(to: classLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
