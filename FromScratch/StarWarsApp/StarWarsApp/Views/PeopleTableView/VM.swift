//
//  VM.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelInputs {
    var nextPage: BehaviorRelay<Void> { get }
}

public protocol ViewModelOuputs {
    var objects: Driver<[String]> { get }
}

public protocol TrendingViewModelType {
    var inputs: ViewModelInputs { get  }
    var outputs: ViewModelOuputs { get }
}

class ViewModel: TrendingViewModelType, ViewModelInputs, ViewModelOuputs {
    
    public var inputs: ViewModelInputs { return self }
    public var outputs: ViewModelOuputs { return self }
    
    internal var nextPage: BehaviorRelay<Void> = BehaviorRelay<Void>(value: ())
    internal var objects: Driver<[String]>
    
    private let pagination = BehaviorRelay<Int>(value: 1)
    private let itemsRelay = BehaviorRelay<[String]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(external: @escaping (_ page: Int) -> (Driver<[Person]>)) {
        objects = itemsRelay.asDriver()
        
        // Contains actual response from request after pagination changed
        let page = pagination
            .flatMap { external($0) }
            .share()
        
        // Concatenates previous results with results from page
        page.map { $0 }
            .withLatestFrom(itemsRelay) { $0 + $1 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)
        
        // Keeps track of current page
        nextPage.skip(1)
            .withLatestFrom(pagination) { $1 + 1 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)
    }
    
}
