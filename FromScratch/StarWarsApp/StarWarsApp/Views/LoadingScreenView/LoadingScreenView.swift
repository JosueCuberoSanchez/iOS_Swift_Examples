//
//  LoadingScreenView.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {
    
    var spinner: UIActivityIndicatorView!
    var loadingLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(ErrorsEnum.nsCoderInitError.rawValue)
    }
    
    /**
     Initialized and sets up all the required subviews.
     */
    private func setupView() {
        initializeSubviews()
        enableAutolayoutForSubviews()
        customizeSubviews()
        addSubviewsToView()
        activateStaticViewConstraints()
        showLoadingScreen()
    }
    
    /**
     Initializes the subviews
     */
    private func initializeSubviews() {
        spinner = UIActivityIndicatorView()
        loadingLabel = UILabel()
    }
    
    /**
     Enables autolayout support for the subviews
     */
    private func enableAutolayoutForSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Adds the subviews to the view.
     */
    private func addSubviewsToView() {
        self.addSubview(spinner)
        self.addSubview(loadingLabel)
    }
    
    /**
     Customizes the subviews properties.
     */
    private func customizeSubviews() {
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = R.string.localizable.loadingMessage()
        spinner.style = .gray
    }
    
    /**
     Active the constraints for the static views.
     */
    private func activateStaticViewConstraints() {
        // Spinner
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            spinner.trailingAnchor.constraint(equalTo: loadingLabel.leadingAnchor, constant: -5)
        ])
        
        // Label
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10)
        ])
    }
    
    /**
     Hides the loading screen
     */
    func hideLoadingScreen() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
    
    /**
     Shows the loading screen
     */
    func showLoadingScreen() {
        spinner.startAnimating()
        spinner.isHidden = false
        loadingLabel.isHidden = false
    }
    
}
