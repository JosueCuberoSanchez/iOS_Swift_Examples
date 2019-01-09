//
//  LoadingScreenView.swift
//  StarWarsApp
//
//  Created by Josue on 1/9/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {
    
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    /**
     Sets a loading screen on the given tableView
     - Parameter height: The frame height
     - Parameter tableView: The table view that will contain this view
     */
    func setLoadingScreen(_ height: CGFloat, _ tableView: UITableView) {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - height
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.isOpaque = true
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = UIConstants.LOADING
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.style = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        self.addSubview(spinner)
        self.addSubview(loadingLabel)
        
        tableView.addSubview(self)
        
    }
    
    /**
     Hides the loading screen
     */
    func removeLoadingScreen() {
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
