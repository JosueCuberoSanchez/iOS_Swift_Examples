//
//  SpeciesServices.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

protocol SpeciesServiceProtocol {
    func getSpecies(_ page: Int) -> Observable<[Specie]>
    func getSpecie(_ resource: URL) -> Observable<Specie>
}

class SpeciesService: SpeciesServiceProtocol {
    
    func getSpecies(_ page: Int) -> Observable<[Specie]> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
    func getSpecie(_ resource: URL) -> Observable<Specie> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
}
