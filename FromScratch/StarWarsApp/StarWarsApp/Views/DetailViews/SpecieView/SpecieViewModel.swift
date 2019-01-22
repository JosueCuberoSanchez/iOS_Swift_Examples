//
//  SpecieViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SpecieViewModel {

    // Inputs
    private var specieDriver: Driver<Specie>

    // Outputs
    var specieName: Driver<String>
    var specieClassification: Driver<String>
    var specieAverageHeight: Driver<String>
    var specieLanguage: Driver<String>
    var specieHomeworld: Driver<String>

    private var disposeBag = DisposeBag()

    init(request: @escaping (_ planetIndex: Int) -> Observable<Response<PlanetResponse>>, specie: Specie) {

        // Asign personDriver
        specieDriver = Driver.of(specie)

        // Map homeworld driver
        // Observable<Response<PlanetResponse>>
        let sharedRequest = specieDriver.asObservable().flatMap { request($0.homeworld.resourceIndex!) }.share()
        let planetResponse = sharedRequest.mapSuccess()

        // Map each Driver to the corresponding person attribute
        specieName = specieDriver.map { $0.name }
        specieClassification = specieDriver.map { $0.classification }
        specieAverageHeight = specieDriver.map { $0.averageHeight }
        specieLanguage = specieDriver.map { $0.language }
        specieHomeworld = planetResponse.map { $0.name }.asDriver(onErrorDriveWith: Driver.empty())

    }

}
