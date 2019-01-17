//
//  StarWarsAppTests.swift
//  StarWarsAppTests
//
//  Created by Josue on 1/17/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import StarWarsApp

class StarWarsAppPersonViewModelTests: XCTestCase {
    
    private var personViewModel: PersonViewModel!
    private let apiClient = APIClient()
    
    // Networking constants
    private final let planetsResource = "planets/"
    
    // Person constants
    private final let personName = "Luke Skywalker"
    private final let personHeight = "1.3"
    private final let personHomeworldURL = "https://swapi.co/api/planets/12/"
    private final let personHomeworld = "Utapau" // this should be the planet 12 name
    private final let personGender = Person.Gender.male

    override func setUp() {
        
        // Set up view model
        let resource = Resource(planetsResource)
        let person = Person(height: personHeight, homeworld: personHomeworldURL, name: personName, gender: personGender)
        personViewModel = PersonViewModel(apiClient.getResponse(resource), person)
        
    }
    
    func testPersonViewModel() {
        XCTAssertEqual(try! personViewModel.personName?.asObservable().toBlocking().first(), personName)
        XCTAssertEqual(try! personViewModel.personHeight?.asObservable().toBlocking().first(), personHeight)
        XCTAssertEqual(try! personViewModel.personHomeworld?.asObservable().toBlocking().first(), personHomeworld)
        XCTAssertEqual(try! personViewModel.personGender?.asObservable().toBlocking().first(), Person.Gender.male.rawValue)
    }

    // The next test were just used to test the blocking observable basic operators
    func testFirst() {
        let observableToTest = Observable.of(10, 20, 30)
        XCTAssertEqual(try! observableToTest.toBlocking().first(), 10)
    }
    
    func testLast() {
        let observableToTest = Observable.of(10, 20, 30)
        XCTAssertEqual(try! observableToTest.toBlocking().last(), 30)
    }
    
    func testAsynchronousToArray(){
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        let intObservbale = Observable.of(10, 20, 30)
            .map{ $0 * 2 }
            .subscribeOn(scheduler)
        
        do{
            let result = try intObservbale.observeOn(MainScheduler.instance).toBlocking().toArray()
            XCTAssertEqual(result, [20, 40, 60])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    override func tearDown() { }

}
