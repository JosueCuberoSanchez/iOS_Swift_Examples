//
//  StarWarsAppSpeciesTableViewModelTests.swift
//  StarWarsAppTests
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import StarWarsApp

class StarWarsAppspecieTableViewModelTests: XCTestCase {

    private var specieTableViewModel: SpeciesTableViewModel!

    private var specieList: [Specie]!
    private var specieListAfertAnotherFetch: [Specie]!

    override func setUp() {
        super.setUp()
        mockupSpecieList()
        mockupSpecieTableViewModel()
    }

    private func mockupSpecieList() {
        let specie1 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie2 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie3 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie4 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie5 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie6 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie7 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie8 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie9 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        let specie10 =
            Specie(averageHeight: "1", language: "Yodiano", homeworld: "Naboo",
                   name: "Yoda specie", classification: "Unown")
        specieList = [specie1, specie2, specie3, specie4, specie5, specie6, specie7, specie8, specie9, specie10]
        specieListAfertAnotherFetch = specieList + specieList
    }

    private func mockSpecieResponse() -> (_ index: Int) -> Observable<Response<SpeciesResponse>> {
        return { index in
            let specieResponse = SpeciesResponse(count: 0, next: "", previous: "", species: self.specieList)
            let response = Response.success(specieResponse)
            return Observable.of(response)
        }
    }

    private func mockupSpecieTableViewModel() {
        specieTableViewModel = SpeciesTableViewModel(request: mockSpecieResponse())
    }

    // Drivers
    func testSpecieListDriver() {
        XCTAssertEqual(try specieTableViewModel.specieList.asObservable().toBlocking().first(), specieList!)
    }

    // Drivers
    func testSpecieListDriverAfterAnotherFetch() {
        specieTableViewModel.nextPageTrigger.accept(())
        XCTAssertEqual(try
            specieTableViewModel.specieList.asObservable().toBlocking().first(), specieListAfertAnotherFetch)
    }

    override func tearDown() {
        specieTableViewModel = nil
        super.tearDown()
    }

}
