//
//  MockLeagueEventsAPITests.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject


final class MockLeagueEventsAPITests: XCTestCase {
    
    var networkManager: MockLeagueEventsAPI!
    
    override func setUpWithError() throws {
        networkManager = MockLeagueEventsAPI(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testGetEvents() {
        let predicatedCount = 10
        var actualCount: Int?
        var error: NSError?
        
        networkManager.getEvents(met: "", leagueId: 1, from: "", to: "", APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                actualCount = success?.result?.count
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertEqual(actualCount, predicatedCount, "Eventss count equal 10")
    }
    
    func testGetTennisEvent() {
        let predicatedCount = 20
        var actualCount: Int?
        var error: NSError?
        
        networkManager.getAllTeams(met: "", leagueId: 1, APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                actualCount = success?.result?.count
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertEqual(actualCount, predicatedCount, "Teams count equal 20")
    }
    
    func testGetTennisEvents() {
        let predicatedCount = 29
        var actualCount: Int?
        var error: NSError?
        
        networkManager.getTennisEvents(met: "", leagueId: 1, from: "", to: "", APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                actualCount = success?.result?.count
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertEqual(actualCount, predicatedCount, "Tennis events count equal 29")
    }
    
    
    func testGetTennisPlayers() {
        let predicatedCount = 47
        var actualCount: Int?
        var error: NSError?
        
        networkManager.getTennisPlayers(met: "", leagueId: 1, APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                actualCount = success?.result?.count
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertEqual(actualCount, predicatedCount, "Tennis players count equal 47")
    }

}
