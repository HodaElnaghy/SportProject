//
//  LeaguesAPITests.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 11/10/2023.
//

import XCTest
@testable import SportsProject

final class LeaguesAPITests: XCTestCase {

    var sut:  LeaguesAPIProtocol!
    
    override func setUpWithError() throws {
        sut = LeaguesAPI()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Football Leagues
    func testGetLeaguesDataFootball() {
        let expectation =  XCTestExpectation(description: "Football Leagues Data Downloaded")
        var response: LeaguesData?
        var error: NSError?
        sut.getLeaguesData(met: Met.leagues.rawValue, APIKey: Token.APIKey, pathURL: SportType.football.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                XCTFail("Result returned was nil")
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    
    // MARK: - Basketball Leagues
    func testGetLeaguesDataBasketball() {
        let expectation =  XCTestExpectation(description: "Basketball Leagues Data Downloaded")
        var response: LeaguesData?
        var error: NSError?
        sut.getLeaguesData(met: Met.leagues.rawValue, APIKey: Token.APIKey, pathURL: SportType.basketball.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                XCTFail("Result returned was nil")
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    
    // MARK: - Cricket Leagues
    func testGetLeaguesDataCricket() {
        let expectation =  XCTestExpectation(description: "Cricket Leagues Data Downloaded")
        var response: LeaguesData?
        var error: NSError?
        sut.getLeaguesData(met: Met.leagues.rawValue, APIKey: Token.APIKey, pathURL: SportType.cricket.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                XCTFail("Result returned was nil")
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    
    // MARK: - Tennis Leagues
    func testGetLeaguesDataTennis() {
        let expectation =  XCTestExpectation(description: "Tennis Leagues Data Downloaded")
        var response: LeaguesData?
        var error: NSError?
        sut.getLeaguesData(met: Met.leagues.rawValue, APIKey: Token.APIKey, pathURL: SportType.tennis.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                XCTFail("Result returned was nil")
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    
}
