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

class PersonViewController: UIViewController, DetailViewControllerProtocol {
    
    let apiClient: APIClient
    var personViewModel: PersonViewModel
    let disposeBag = DisposeBag()
    
    // subviews
    var personImageView: UIImageView!
    var nameLabel: UILabel!
    var genderLabel: UILabel!
    var heightLabel: UILabel!
    var homeworldLabel: UILabel!
    
    private final let planetsResource = "planets/"
    
    init(_ person: Person) {
        
        // Get API Client
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        apiClient = appDelegate.apiClient
        
        // Initialize VM
        let resource = Resource(planetsResource)
        personViewModel = PersonViewModel(apiClient.getResponse(resource), person)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Segue performed by storyboard, should be programatically")
    }
    
    override func loadView() {
        super.loadView()

        setupSubviews()
        customizeView()
        customizeSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    func setupSubviews() {
        
        let personImageView = UIImageView(image: #imageLiteral(resourceName: "bb8"))
        let nameLabel = UILabel(frame: CGRect.zero)
        let genderLabel = UILabel(frame: CGRect.zero)
        let heightLabel = UILabel(frame: CGRect.zero)
        let homeworldLabel = UILabel(frame: CGRect.zero)
        
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(personImageView)
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(heightLabel)
        view.addSubview(homeworldLabel)
        
        // Image
        NSLayoutConstraint.activate([
            personImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 180),
            personImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50),
            // Conflicting constraints
            //personImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 50),
            //personImageView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 50)
        ])
        
        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor, constant: -32)
        ])
        
        // Gender
        NSLayoutConstraint.activate([
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLabel.bottomAnchor.constraint(equalTo: heightLabel.topAnchor, constant: -32)
        ])
        
        // Height
        NSLayoutConstraint.activate([
            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightLabel.bottomAnchor.constraint(equalTo: homeworldLabel.topAnchor, constant: -32)
        ])
        
        // Homeworld
        NSLayoutConstraint.activate([
            homeworldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeworldLabel.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -500)
        ])
        
        self.personImageView = personImageView
        self.nameLabel = nameLabel
        self.genderLabel = genderLabel
        self.heightLabel = heightLabel
        self.homeworldLabel = homeworldLabel
    }
    
    /**
     Customize this viewController view
        Sets the background image with all its properties
     */
    private func customizeView() {
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let image = UIImage(named: R.string.localizable.backGroundImageName())
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image

        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    /**
     Customizes the style, properties, positions and constraints of the viewController view subviews.
     */
    private func customizeSubviews() {
        setLabelFonts()
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
