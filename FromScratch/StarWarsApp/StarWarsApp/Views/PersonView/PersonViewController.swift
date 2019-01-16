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

class PersonViewController: UIViewController, UIScrollViewDelegate, DetailViewControllerProtocol {
    
    private let apiClient: APIClient
    private let personViewModel: PersonViewModel
    private let disposeBag = DisposeBag()
    
    // Subviews
    private var scrollView: UIScrollView!
    private var personImageView: UIImageView!
    private var nameLabel: UILabel!
    private var genderLabel: UILabel!
    private var heightLabel: UILabel!
    private var homeworldLabel: UILabel!
    private var backgroundImageView: UIImageView!
    
    // Networking constants
    private final let planetsResource = "planets/"
    
    // Dynamic constraints
    private var portraitImageViewTopAnchorConstant: [NSLayoutConstraint]!
    private var landscapeImageViewTopAnchorConstant: [NSLayoutConstraint]!
    
    init(_ person: Person) {
        
        // Get API Client from App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        apiClient = appDelegate.apiClient
        
        // Initialize ViewModel
        let resource = Resource(planetsResource)
        personViewModel = PersonViewModel(apiClient.getResponse(resource), person)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(ErrorsEnum.nsCoderInitError.rawValue)
    }
    
    override func loadView() {
        super.loadView()    
        setupSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateDynamicViewConstraints()
    }
    
    /**
     Initialized and sets up all the required subviews.
     */
    private func setupSubviews() {
        
        // Views
        initializeSubviews()
        enableAutolayoutForSubviews()
        setupBackgroundImageView()
        addSubviewsToView()
        setupScrollView()
        setLabelFonts()
        
        // Constraints
        initializeDynamicViewConstraints()
        updateDynamicViewConstraints()
        activateStaticViewConstraints()
        
    }
    
    /**
     Initializes the subviews
     */
    private func initializeSubviews() {
        scrollView = UIScrollView()
        personImageView = UIImageView(image: #imageLiteral(resourceName: "bb8"))
        nameLabel = UILabel()
        genderLabel = UILabel()
        heightLabel = UILabel()
        homeworldLabel = UILabel()
        backgroundImageView = UIImageView()
    }
    
    /**
     Enables autolayout support for the subviews
     */
    private func enableAutolayoutForSubviews() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Sets up the background image view.
     */
    private func setupBackgroundImageView() {
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = UIImage(named: R.string.localizable.backGroundImageName())
    }
    
    /**
     Adds the subviews to the view.
     */
    private func addSubviewsToView() {
        view = scrollView
        view.addSubview(personImageView)
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(heightLabel)
        view.addSubview(homeworldLabel)
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    /**
     Sets up the scroll view properties (size, scrollable)
     */
    private func setupScrollView() {
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: view.frame.size.height, height: view.frame.size.width)
        }
        scrollView.isScrollEnabled = true
    }
    
    /**
     Sets the Star Wars font for the UILabels.
     */
    private func setLabelFonts() {
        nameLabel.setFontStyleFor(.label)
        genderLabel.setFontStyleFor(.label)
        heightLabel.setFontStyleFor(.label)
        homeworldLabel.setFontStyleFor(.label)
    }
    
    /**
     Initializes the dynamic view constraints (Dynamic on orientation changes).
     */
    private func initializeDynamicViewConstraints() {
        portraitImageViewTopAnchorConstant = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 180),
            personImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50),
        ]
        landscapeImageViewTopAnchorConstant = [
            personImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 30),
            personImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50),
        ]
    }
    
    /**
     Updates the dynamic views according to the current orientation.
     */
    private func updateDynamicViewConstraints() {
        
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.activate(landscapeImageViewTopAnchorConstant)
            NSLayoutConstraint.deactivate(portraitImageViewTopAnchorConstant)
        } else {
            NSLayoutConstraint.activate(portraitImageViewTopAnchorConstant)
            NSLayoutConstraint.deactivate(landscapeImageViewTopAnchorConstant)
        }
        
    }
    
    /**
     Active the constraints for the static views.
     */
    private func activateStaticViewConstraints() {
        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor, constant: -32)
        ])
        
        // Gender
        NSLayoutConstraint.activate([
            genderLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            genderLabel.bottomAnchor.constraint(equalTo: heightLabel.topAnchor, constant: -32)
        ])
        
        // Height
        NSLayoutConstraint.activate([
            heightLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            heightLabel.bottomAnchor.constraint(equalTo: homeworldLabel.topAnchor, constant: -32)
        ])
        
        // Homeworld
        NSLayoutConstraint.activate([
            homeworldLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            homeworldLabel.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -30)
        ])
        
        // Background image
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    /**
     Bind the subviews data to the viewModel's behaviour relays.
     */
    private func setupBindings() {
        /// Name
        personViewModel.personName?
            .asObservable()
            .map { $0.addingNameLabel() }
            .bind(to:nameLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Gender
        personViewModel.personGender?
            .asObservable()
            .map { $0.addingGenderLabel() }
            .bind(to:genderLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Height
        personViewModel.personHeight?
            .asObservable()
            .map { $0.addingHeightLabel() }
            .bind(to:heightLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Homeworld
        personViewModel.personHomeworld?
            .asObservable()
            .map { $0.addingHomeworldLabel() }
            .bind(to:homeworldLabel.rx.text)
            .disposed(by:disposeBag)
    }

}
