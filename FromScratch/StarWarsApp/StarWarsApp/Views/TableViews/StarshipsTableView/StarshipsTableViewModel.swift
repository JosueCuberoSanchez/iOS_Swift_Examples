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

class StarshipsTableViewModel {

    private let disposeBag = DisposeBag()

    // Pagination helpers
    private var pagination = BehaviorRelay<Int>(value: 1)
    private var activityIndicator = ActivityIndicator()
    private var itemsRelay = BehaviorRelay<[Starship]>(value: [])
    var nextPageTrigger = PublishRelay<Void>()

    // Filter helpers
    let filterSource = BehaviorRelay<String>(value: "")

    // Outputs
    let starshipList: Driver<[Starship]>

    // Constants
    private var maxPage = 5

    init(request: @escaping (_ page: Int) -> Observable<Response<StarshipsResponse>>) {

        starshipList = Driver.combineLatest(itemsRelay.asDriver(), filterSource.asDriver()) { data, filter in
            data.filter { starship in
                guard filter != "" else {
                    return true
                }
                return starship.name.lowercased().contains(filter.lowercased())
            }
        }

        let sharedRequest =
            pagination.flatMap { request($0).trackActivity(self.activityIndicator) }.share()
        let starshipsResponse = sharedRequest.mapSuccess()

        starshipsResponse.map { $0.starships }
            .withLatestFrom(itemsRelay) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)

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
