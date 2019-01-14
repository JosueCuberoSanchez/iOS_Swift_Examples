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
    
    // Input and output
    public var inputs: PersonViewModel { return self }
    public var outputs: PersonViewModel { return self }
    
    // Inputs
    var person: Driver<Person>?
    
    // Outputs
    var personName = BehaviorRelay<String>(value: "")
    var personHeight = BehaviorRelay<String>(value: "")
    var personGender = BehaviorRelay<String>(value: "")
    var personHomeworld = BehaviorRelay<String>(value: "")
    var personHomeworldURL = BehaviorRelay<String>(value: "")
    
    var disposeBag = DisposeBag()
    
    /**
     Get the current person values and set them to their corresponding Behaviour Relays, so the ViewController can bind its labels to them.
     */
    func setOutputs() {
        
        person?.asObservable().subscribe({
            if let person = $0.element {
                self.personName.accept(person.name)
                self.personHeight.accept(person.height)
                self.personGender.accept(person.gender.rawValue.capitalizingFirstLetter())
                self.personHomeworldURL.accept(person.homeworld)
            }
        }).disposed(by: disposeBag)
        
    }
    
    /**
     Loads the current person planet and drives it to its corresponding Behavior Relay.
     */
    func loadPersonPlanet(request: @escaping (_ planetURL: String) -> Observable<PlanetResponse>) {
        
        let sharedRequest = personHomeworldURL.flatMap{ request($0) }.share()
        
        sharedRequest.map { $0.name }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(personHomeworld)
            .disposed(by: disposeBag)
        
    }

}
