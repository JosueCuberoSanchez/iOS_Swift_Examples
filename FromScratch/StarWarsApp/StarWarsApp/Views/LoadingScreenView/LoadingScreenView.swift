//
//  LoadingScreenView.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {
    
    var spinner = UIActivityIndicatorView()
    var loadingLabel = UILabel(frame: CGRect.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(spinner)
        self.addSubview(loadingLabel)
        
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
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = R.string.localizable.loadingMessage()
        
        // Sets spinner
        spinner.style = .gray
        
        showLoadingScreen()
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
