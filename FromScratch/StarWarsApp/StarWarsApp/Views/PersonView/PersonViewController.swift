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
    
    let apiClient = APIClient()
    var personViewModel = PersonViewModel()
    var disposeBag = DisposeBag()
    
    // subviews
    var personImageView: UIImageView!
    var nameLabel: UILabel!
    var genderLabel: UILabel!
    var heightLabel: UILabel!
    var homeworldLabel: UILabel!
    
    private final let planetsResource = "planets/"
    
    
    override func loadView() {
        super.loadView()

        setupSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        setupViewModel()
        customizeSubviews()
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
            personImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            personImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180),
            personImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50)
        ])
        
        // Name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor, constant: -32)
        ])
        
        // Gender
        NSLayoutConstraint.activate([
            genderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            genderLabel.bottomAnchor.constraint(equalTo: heightLabel.topAnchor, constant: -32)
        ])
        
        // Height
        NSLayoutConstraint.activate([
            heightLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            heightLabel.bottomAnchor.constraint(equalTo: homeworldLabel.topAnchor, constant: -32)
        ])
        
        // Homeworld
        NSLayoutConstraint.activate([
            homeworldLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //homeworldLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor, constant: 1)
        ])
        
        self.personImageView = personImageView
        self.nameLabel = nameLabel
        self.genderLabel = genderLabel
        self.heightLabel = heightLabel
        self.homeworldLabel = homeworldLabel
    }
    
    func setPerson(_ person: Driver<Person>) {
        personViewModel.person = person
    }
    
    /**
     Customize this viewController view
        Sets the background image with all its properties
     */
    private func customizeView() {
        let background = UIImage(named: R.string.localizable.backGroundImageName())
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = false
        imageView.image = background
        imageView.alpha = UIConstants.BACKGROUND_IMAGE_ALPHA
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
    }

    /**
     Sets up the view model passing as a parameter a closure for the API requests.
     */
    private func setupViewModel() {
        personViewModel.setOutputs()
        let resource = Resource(planetsResource)
        personViewModel.loadPersonPlanet(request: apiClient.getResponse(resource))
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
        nameLabel.setFontStyle(.label)
        genderLabel.setFontStyle(.label)
        heightLabel.setFontStyle(.label)
        homeworldLabel.setFontStyle(.label)
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
