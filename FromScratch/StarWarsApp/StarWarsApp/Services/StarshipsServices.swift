//
//  StarshipsServices.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

protocol StarshipsServiceProtocol {
    func getStarships(_ page: Int) -> Observable<[Starship]>
    func getStarship(_ resource: URL) -> Observable<Starship>
}

class StarshipsService: StarshipsServiceProtocol {
    
    func getStarships(_ page: Int) -> Observable<[Starship]> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
    func getStarship(_ resource: URL) -> Observable<Starship> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            return Disposables.create()
        }
    }
    
}
