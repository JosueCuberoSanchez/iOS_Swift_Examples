//
//  PeopleServices.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

protocol PeopleServiceProtocol {
    func getPeople(_ page: Int) -> Observable<[Person]>
    func getPerson(_ resource: URL) -> Observable<Person>
}

class PeopleService: PeopleServiceProtocol {
    
    func getPeople(_ page: Int) -> Observable<[Person]> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
    func getPerson(_ resource: URL) -> Observable<Person> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
}
