//
//  Errors.swift
//  StarWarsApp
//
//  Created by Josue on 1/14/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum ErrorsEnum: String {
    case baseURLError = "Unable to create base URL"
    case URLComponentsError = "Unable to create URL components"
    case URLError = "Could not get URL"
    case fontLoadError = "Could not load font"
}
