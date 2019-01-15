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
    var person: Driver<Person>?
    
    // Outputs
    var personName: Driver<String>?
    var personHeight: Driver<String>?
    var personGender: Driver<String>?
    var personHomeworld: Driver<String>?
    var personHomeworldURL = BehaviorRelay<String>(value: "")
    
    let itemRelay = BehaviorRelay<String>(value: "")
    
    var disposeBag = DisposeBag()
    
    /**
     Get the current person values and set them to their corresponding Behaviour Relays, so the ViewController can bind its labels to them.
     */
    func setOutputs() {
        
        person?.asObservable().subscribe({ [weak self] in
            if let person = $0.element {
                self?.personName = Driver.of(person.name)
                self?.personHeight = Driver.of(person.height)
                self?.personGender = Driver.of(person.gender.rawValue)
                self?.personHomeworldURL.accept(person.homeworld)
            }
        }).disposed(by: disposeBag)
        
    }
    
    /**
     Loads the current person planet and drives it to its corresponding Behavior Relay.
     */
    func loadPersonPlanet(request: @escaping (_ planetIndex: Int, _ requestType: Resource.RequestType) -> Observable<PlanetResponse>) {
        
        let sharedRequest = personHomeworldURL.flatMap{ request($0.resourceIndex,Resource.RequestType.nonParametrized) }.share()
        
        sharedRequest.map { $0.name }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemRelay)
            .disposed(by: disposeBag)
        
        personHomeworld = itemRelay.asDriver()
        
    }

}

extension String {
    
    var resourceIndex: Int {
        let planet = self.dropLast()
        let fileArray = planet.components(separatedBy: "/")
        return Int(fileArray.last!)!
    }
    
}
