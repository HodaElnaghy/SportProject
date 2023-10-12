//
//  TeamAPITests.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 11/10/2023.
//

import XCTest
@testable import SportsProject

final class TeamAPITests: XCTestCase {

    var sut:  TeamAPIProtocol!
    var footballID: Int!
    var basketballID: Int!
    var cricketID: Int!
    
    override func setUpWithError() throws {
        sut = TeamAPI()
        footballID = 96
        basketballID = 2616
        cricketID = 138
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Football Team & Players data
    func testGetTeamDataFootball() {
        let expectation =  XCTestExpectation(description: "Football teams data downloaded")
        var response: TeamData?
        var players: [Players]?
        var error: NSError?
        sut.getTeamData(met: Met.teams.rawValue, teamId: footballID, APIkey: Token.APIKey, pathURL: SportType.football.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
                players = response?.result?.first?.players
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
        XCTAssertNotNil(players)
    }
    
    
    // MARK: - Basketball Team & Players data
    func testGetTeamDataBasketball() {
        let expectation =  XCTestExpectation(description: "Basketball teams data downloaded")
        var response: TeamData?
        var players: [Players]?
        var error: NSError?
        sut.getTeamData(met: Met.teams.rawValue, teamId: basketballID, APIkey: Token.APIKey, pathURL: SportType.basketball.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
                players = response?.result?.first?.players
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
        //XCTAssertNotNil(players) // will fail, API only returns players for football
    }
    
    // MARK: - Cricket Team & Players data
    func testGetTeamDataCricket() {
        let expectation =  XCTestExpectation(description: "Cricket teams data downloaded")
        var response: TeamData?
        var players: [Players]?
        var error: NSError?
        sut.getTeamData(met: Met.teams.rawValue, teamId: cricketID, APIkey: Token.APIKey, pathURL: SportType.cricket.rawValue){ result in
            switch result {
            case .success(let success):
                response = success
                players = response?.result?.first?.players
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
        //XCTAssertNotNil(players) // will fail, API only returns players for football
    }
    

}
