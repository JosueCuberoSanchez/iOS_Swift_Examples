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
    
    var x: CGFloat?
    var y: CGFloat?
    
    /**
     Sets a loading screen on the given tableView
     - Parameter height: The frame height
     - Parameter tableView: The table view that will contain this view
     */
    func setLoadingScreen(_ navBarHeight: CGFloat, _ view: UIView) {
        
        // Sets the view which contains the loading text and the spinner
        x = (view.frame.width / UIConstants.FRAME_DIVISOR) - (UIConstants.FRAME_WIDTH / UIConstants.FRAME_DIVISOR)
        y = (view.frame.height / UIConstants.FRAME_DIVISOR) - (UIConstants.FRAME_HEIGTH / UIConstants.FRAME_DIVISOR) - navBarHeight
        self.frame = CGRect(x: x!, y: y!, width: UIConstants.FRAME_WIDTH, height: UIConstants.FRAME_HEIGTH)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = UIConstants.LOADING
        loadingLabel.frame =
            CGRect(x: UIConstants.INITIAL_FRAME_ORIGIN, y: UIConstants.INITIAL_FRAME_ORIGIN,
                                    width: UIConstants.LOADING_LABEL_WIDTH, height: UIConstants.LOADING_LABEL_HEIGHT)
        
        // Sets spinner
        spinner.style = .gray
        spinner.frame =
            CGRect(x: UIConstants.INITIAL_FRAME_ORIGIN, y: UIConstants.INITIAL_FRAME_ORIGIN,
                   width: UIConstants.SPINNER_WIDTH, height: UIConstants.SPINNER_HEIGHT)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        self.addSubview(spinner)
        self.addSubview(loadingLabel)
        
        view.addSubview(self)
        
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
        self.frame = CGRect(x: Int(x!), y: UIConstants.FRAME_ORIGIN, width: Int(UIConstants.FRAME_WIDTH), height: Int(UIConstants.FRAME_HEIGTH))
    }
    

}
