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
    
    // Input and output
    public var inputs: PeopleTableViewModel { return self }
    public var outputs: PeopleTableViewModel { return self }
    
    var pagination = BehaviorRelay<Int>(value: 1)
    var nextPageTrigger: BehaviorRelay<Void> = BehaviorRelay<Void>(value: ())

    var peopleList: Driver<[Person]>?
    var peopleResponse: Observable<PeopleResponse>?
    let itemsRelay = BehaviorRelay<[Person]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(request: @escaping (_ page: Int) -> Observable<PeopleResponse>) {
        loadPeople(request: request)
    }
    
    func loadPeople(request: @escaping (_ page: Int) -> Observable<PeopleResponse>) {
        
        let sharedRequest = pagination.flatMap{ request($0) }.share()
        
        sharedRequest.map { $0.people }
            .withLatestFrom(itemsRelay) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)
        
        nextPageTrigger.skip(1)
            .withLatestFrom(pagination) { $1 + 1 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)
        
        peopleList = itemsRelay.asDriver()
    }
    
}
