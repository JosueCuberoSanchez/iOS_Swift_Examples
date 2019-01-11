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

class PersonViewController: UIViewController {
    
    let apiClient = APIClient()
    var personViewModel = PersonViewModel()
    var disposeBag = DisposeBag()
    
    // subviews
    var personImageView: UIImageView!
    var nameLabel: UILabel!
    var genderLabel: UILabel!
    var heightLabel: UILabel!
    var homeworldLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        setupViewModel()
        initializeSubviews()
        addSubviews()
        customizeSubviews()
        setupBindings()
    }
    
    
    /**
     Customize this viewController view
        Sets the background image with all its properties
     */
    private func customizeView() {
        let background = UIImage(named: UIConstants.BACKGROUND_IMAGE_NAME)
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = UIConstants.BACKGROUND_IMAGE_ALPHA
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
    }

    /**
     Sets up the view model passing as a parameter a closure for the API requests.
     */
    private func setupViewModel() {
        personViewModel.setOutputs()
        personViewModel.loadPersonPlanet(request: apiClient.getPlanetResponse())
    }
    
    /**
     Initialize all the subviews that will go inside this viewController view.
     */
    private func initializeSubviews() {
        
        // Image View
        let image = #imageLiteral(resourceName: "bb8")
        personImageView = UIImageView(image: image)
        
        // Labels
        nameLabel = UILabel()
        genderLabel = UILabel()
        heightLabel = UILabel()
        homeworldLabel = UILabel()
    }
    
    /**
     Adds all the subviews to this viewController view.
     */
    private func addSubviews(){
        self.view.addSubview(personImageView)
        view.addSubview(nameLabel)
        view.addSubview(genderLabel)
        view.addSubview(heightLabel)
        view.addSubview(homeworldLabel)
    }
    
    /**
     Customizes the style, properties, positions and constraints of the viewController view subviews.
     */
    private func customizeSubviews() {
        setLabelFonts()
        setSubviewsConstraints()
    }
    
    /**
     Sets the Star Wars font for the UILabels.
     */
    private func setLabelFonts() {
        guard let starJediSpecialEditionFont = UIFont(name: UIConstants.STAR_JEDI_SPECIAL_EDITION_FONT_NAME, size: UIFont.labelFontSize) else {
            fatalError(ErrorMessageConstants.FONT_LOAD_ERROR)
        }
        
        nameLabel.font = UIFontMetrics.default.scaledFont(for: starJediSpecialEditionFont)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        genderLabel.font = UIFontMetrics.default.scaledFont(for: starJediSpecialEditionFont)
        genderLabel.adjustsFontForContentSizeCategory = true
        
        heightLabel.font = UIFontMetrics.default.scaledFont(for: starJediSpecialEditionFont)
        heightLabel.adjustsFontForContentSizeCategory = true
        
        homeworldLabel.font = UIFontMetrics.default.scaledFont(for: starJediSpecialEditionFont)
        homeworldLabel.adjustsFontForContentSizeCategory = true
    }
    
    /**
     Sets all the needed constraints of te subviews.
     */
    private func setSubviewsConstraints() {
        
        // Image View
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = NSLayoutConstraint(item: personImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        var verticalConstraint = NSLayoutConstraint(item: personImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -200)
        let widthConstraint = NSLayoutConstraint(item: personImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: personImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        // Name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -50)
        view.addConstraints([horizontalConstraint, verticalConstraint])
        nameLabel.sizeToFit()
        
        // Gender
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: genderLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: genderLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        genderLabel.sizeToFit()
        
        // Height
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: heightLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: heightLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 150)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        heightLabel.sizeToFit()
        
        // Homeworld
        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: homeworldLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: homeworldLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 250)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        homeworldLabel.sizeToFit()
    }
    
    /**
     Bind the subviews data to the viewModel's behaviour relays.
     */
    private func setupBindings() {
        /// Name
        personViewModel.outputs.personName
            .asObservable()
            .map { $0.addingNameLabel() }
            .bind(to:nameLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Gender
        personViewModel.outputs.personGender
            .asObservable()
            .map { $0.addingGenderLabel() }
            .bind(to:genderLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Height
        personViewModel.outputs.personHeight
            .asObservable()
            .map { $0.addingHeightLabel() }
            .bind(to:heightLabel.rx.text)
            .disposed(by:disposeBag)
        
        /// Homeworld
        personViewModel.outputs.personHomeworld
            .asObservable()
            .map { $0.addingHomeworldLabel() }
            .bind(to:homeworldLabel.rx.text)
            .disposed(by:disposeBag)
    }

}
