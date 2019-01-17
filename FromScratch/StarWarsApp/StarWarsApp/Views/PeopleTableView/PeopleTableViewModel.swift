//
//  PeopleViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PeopleTableViewModel {
    
    // Pagination helpers
    private var pagination = BehaviorRelay<Int>(value: 1)
    var nextPageTrigger = BehaviorRelay<Void>(value: ())

    var peopleList: Driver<[Person]>?
    private var itemsRelay = BehaviorRelay<[Person]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(request: @escaping (_ page: Int, _ requestType: Resource.RequestType) -> Observable<Response<PeopleResponse>>) {
        
        let sharedRequest = pagination.flatMap{ request($0,Resource.RequestType.parametrized) }.share() // get the response
        let peopleResponse = sharedRequest.flatMap{ response -> Observable<PeopleResponse> in
            switch response {
            case .success(let peopleResponse):
                return Observable.of(peopleResponse)
            case .failure:
                return Observable.empty()
            }
        }
        
        peopleResponse.map { $0.people } // map people array to items relay
            .withLatestFrom(itemsRelay) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)
        
        // trigger for next page loads, triggers the first time because it has a value already.
        // next triggers are made by the view controller, and pagination changes (+1) making the shared request trigger the next page load.
        nextPageTrigger.skip(1)
            .withLatestFrom(pagination) { $1 + 1 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)
        
        peopleList = itemsRelay.asDriver()
        
    }
    
}
