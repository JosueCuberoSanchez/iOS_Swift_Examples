//
//  PeopleViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

class PeopleTableViewModel {
    
    var peopleResponse: Observable<PeopleResponse>?
    var peopleList: Observable<[Person]>?
    
    init(request: () -> Observable<PeopleResponse>) {
        
        let sharedRequest = request().share() /// Shares the same observable with all the observers
        peopleList = sharedRequest.map({ $0.people })
        peopleResponse = sharedRequest.take(1)
        
    }
    
}
