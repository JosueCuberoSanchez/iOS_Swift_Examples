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

    private let disposeBag = DisposeBag()

    // Pagination helpers
    private var pagination = BehaviorRelay<Int>(value: 1)
    private var activityIndicator = ActivityIndicator()
    private var itemsRelay = BehaviorRelay<[Person]>(value: [])
    var nextPageTrigger = PublishRelay<Void>()

    // Filter helpers
    let filterSource = BehaviorRelay<String>(value: "")

    // Outputs
    let peopleList: Driver<[Person]>

    // Constants
    private var maxPage = 10

    init(request: @escaping (_ page: Int) -> Observable<Response<PeopleResponse>>) {

        peopleList = Driver.combineLatest(itemsRelay.asDriver(), filterSource.asDriver()) { data, filter in
            data.filter { person in
                guard filter != "" else {
                    return true
                }
                return person.name.lowercased().contains(filter.lowercased())
            }
        }

        /* cuando este request comienza es por que el trigger lo dejo pasar por estar en F, 
        entonces el track cambia el AI de F a V, para no dejar pasar a nadie mas.*/
        let sharedRequest =
            pagination.flatMap { request($0).trackActivity(self.activityIndicator) }.share()
        /* cuando este request termina, el track activity se encargar de hacerle decrement 
        al activity indicator, pasando de V a F*/
        let peopleResponse = sharedRequest.mapSuccess()

        peopleResponse.map { $0.people } // map people array to items relay
            .withLatestFrom(itemsRelay) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)

        /* trigger for next page loads, triggers the first time because it has a value already.
           next triggers are made by the view controller, and pagination changes (+1) making 
            the shared request trigger the next page load.*/
        nextPageTrigger
            .withLatestFrom(activityIndicator)
            .filter { !$0 }
            .withLatestFrom(pagination) { $1 + 1 }
            .filter { $0 < self.maxPage }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)

    }

}
