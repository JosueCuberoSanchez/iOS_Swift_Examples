//
//  SpeciesViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SpeciesTableViewModel {

    private let disposeBag = DisposeBag()

    // Pagination helpers
    private var pagination = BehaviorRelay<Int>(value: 1)
    private var activityIndicator = ActivityIndicator()
    var nextPageTrigger = PublishRelay<Void>()

    private var itemsRelay = BehaviorRelay<[Specie]>(value: [])

    // Outputs
    let specieList: Driver<[Specie]>

    init(request: @escaping (_ page: Int) -> Observable<Response<SpeciesResponse>>) {

        specieList = itemsRelay.asDriver()

        /* cuando este request comienza es por que el trigger lo dejo pasar por estar en F, 
         entonces el track cambia el AI de F a V, para no dejar pasar a nadie mas.*/
        let sharedRequest =
            pagination.flatMap { [weak self] in request($0).trackActivity((self?.activityIndicator)!) }.share()
        /* cuando este request termina, el track activity se encargar de hacerle decrement 
         al activity indicator, pasando de V a F*/
        let specieResponse = sharedRequest.mapSuccess()

        specieResponse.map { $0.species } // map people array to items relay
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
            .filter { $0 < 5 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)

    }

}
