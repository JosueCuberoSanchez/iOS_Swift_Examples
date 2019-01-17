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
    
    // Outputs
    var personName: Driver<String>?
    var personHeight: Driver<String>?
    var personGender: Driver<String>?
    var personHomeworld: Driver<String>?
    private var personHomeworldURL =  BehaviorRelay<String>(value: "")
        
    var disposeBag = DisposeBag()
    
    init(_ request: @escaping (_ planetIndex: Int, _ requestType: Resource.RequestType) -> Observable<Response<PlanetResponse>>, _ person: Person) {
        
        // Asign personDriver
        personDriver = Driver.of(person)
        
        // Map homeworld driver
        personDriver.map{ $0.homeworld }.drive(personHomeworldURL).disposed(by: disposeBag) // Assign to personHomeworldURL the URL of the planet as a String
        let sharedRequest = personHomeworldURL.flatMap{ request($0.resourceIndex , Resource.RequestType.nonParametrized) }.share() // Observable<Response<PlanetResponse>>
        let planetResponse = sharedRequest.flatMap{ response -> Observable<PlanetResponse> in
            switch response {
            case .success(let planet):
                return Observable.of(planet)
            case .failure:
                return Observable.empty()
            }
        }
        
        // Map each Driver to the corresponding person attribute
        personName = personDriver.map{ $0.name }
        personGender = personDriver.map{ $0.gender.rawValue }
        personHeight = personDriver.map{ $0.height }
        personHomeworld = planetResponse.map{ $0.name }.asDriver(onErrorJustReturn: "Undefined")
    }

}

extension String {
    
    var resourceIndex: Int {
        return Int(self.dropLast().components(separatedBy: "/").last!)!
    }
    
}
