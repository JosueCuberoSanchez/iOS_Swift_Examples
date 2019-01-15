//
//  ViewControllerProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/14/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

protocol DetailViewControllerProtocol {
    // TODO: Add variables and methods that all the 3 details view controllers will have
}

extension String {
    
    /**
     Add the name label to the current String.
     
     - Returns: Complete name label.
     */
    func addingNameLabel() -> String {
        return "\(R.string.localizable.nameLabel())\(self)"
    }
    
    /**
     Add the gender label to the current String.
     
     - Returns: Complete gender label.
     */
    func addingGenderLabel() -> String {
        return "\(R.string.localizable.genderLabel())\(self)"
    }
    
    /**
     Add the height label to the current String.
     
     - Returns: Complete height label.
     */
    func addingHeightLabel() -> String {
        return "\(R.string.localizable.heightLabel())\(self) ft"
    }
    
    /**
     Add the homeworld label to the current String.
     
     - Returns: Complete homeworld label.
     */
    func addingHomeworldLabel() -> String {
        return "\(R.string.localizable.homeworldLabel())\(self)"
    }
}
