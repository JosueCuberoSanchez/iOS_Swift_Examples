//
//  PersonViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PersonViewModel {
    
    // Inputs
    var personDriver: Driver<Person>
    var planetResponse: Observable<PlanetResponse>
    
    // Outputs
    var personName: Driver<String>?
    var personHeight: Driver<String>?
    var personGender: Driver<String>?
    var personHomeworld: Driver<String>?
    var personHomeworldURL =  BehaviorRelay<String>(value: "")
        
    var disposeBag = DisposeBag()
    
    init(_ request: @escaping (_ planetIndex: Int, _ requestType: Resource.RequestType) -> Observable<PlanetResponse>, _ person: Person) {
        
        // Asign personDriver
        personDriver = Driver.of(person)
        
        // Map homeworld driver
        personDriver.map{ $0.homeworld }.drive(personHomeworldURL).disposed(by: disposeBag) // Assign to personHomeworldURL the URL of the planet as a String
        self.planetResponse = personHomeworldURL.flatMap{ request($0.resourceIndex , Resource.RequestType.nonParametrized) } // Get a planetResponse
        
        // Map each Driver to the corresponding person attribute
        self.personName = personDriver.map{ $0.name }
        self.personGender = personDriver.map{ $0.gender.rawValue }
        self.personHeight = personDriver.map{ $0.height }
        self.personHomeworld = planetResponse.map{ $0.name }.asDriver(onErrorJustReturn: "")
    }

}

extension String {
    
    var resourceIndex: Int {
        let planet = self.dropLast()
        let fileArray = planet.components(separatedBy: "/")
        return Int(fileArray.last!)!
    }
    
}
