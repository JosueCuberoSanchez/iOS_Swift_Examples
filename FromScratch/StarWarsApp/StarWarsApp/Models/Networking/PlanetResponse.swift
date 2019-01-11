//
//  PlanetResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PlanetResponse: Codable {
    
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    
    init(name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String,
         climate: String, gravity: String, terrain: String, surfaceWater: String,
         population: String, residents: [String]) {
        self.name = name
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.population = population
        self.residents = residents
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
    }
}
