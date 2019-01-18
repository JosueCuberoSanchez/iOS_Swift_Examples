//
//  Errors.swift
//  StarWarsApp
//
//  Created by Josue on 1/14/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum ErrorEnum: String {
    case baseURLError = "Unable to create base URL."
    case urlComponentsError = "Unable to create URL components."
    case urlError = "Could not get URL."
    case nilParametersError = "One or more parameters were nil while building the request."
    case responseError = "Response could not be retrieved successfully."
    case fontLoadError = "Could not load font."
    case nsCoderInitError = "NS Coder init fatal error."
}
