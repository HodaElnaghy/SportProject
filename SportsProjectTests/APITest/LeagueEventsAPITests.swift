//
//  LeagueEventsAPITests.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject

final class LeagueEventsAPITests: XCTestCase {

    var sut:  LeagueEventsAPIProtocol!
    var upcomingFrom: String!
    var upcomingTo: String!
    var latestTo: String!
    var latestFrom: String!
    var footballID: Int!
    var basketballID: Int!
    var cricketID: Int!
    var tennisID: Int!
    
    override func setUpWithError() throws {
        sut = LeagueEventsAPI()
        upcomingFrom = DateManager.shared.currentDateInStringFormat()
        upcomingTo = DateManager.shared.nextDateInStringFormat(14)
        latestFrom = DateManager.shared.previousDaysInStringFormat(-14)
        latestTo = DateManager.shared.currentDateInStringFormat()

        footballID = 207 //152
        basketballID = 967
        cricketID = 733
        tennisID = 3773
    }
    
    override func tearDownWithError() throws {
        sut = nil
        upcomingFrom = nil
        upcomingTo = nil
        latestTo = nil
        latestFrom = nil
    }

    // MARK: - Football Upcoming Events
    func testGetEventsFootballUpcoming() {
        let expectation =  XCTestExpectation(description: "Football upcoming event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: footballID, from: upcomingFrom, to: upcomingTo, APIkey: Token.APIKey, pathURL: SportType.football.rawValue) { result in
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
    
    // MARK: - Football Latest Events
    func testGetEventsFootballLatest() {
        let expectation =  XCTestExpectation(description: "Football latest event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: footballID, from: latestFrom, to: latestTo, APIkey: Token.APIKey, pathURL: SportType.football.rawValue) { result in
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

    // MARK: - Basketball Upcoming Events
    func testGetEventsBasketballUpcoming() {
        let expectation =  XCTestExpectation(description: "Basketball upcoming event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: basketballID, from: upcomingFrom, to: upcomingTo, APIkey: Token.APIKey, pathURL: SportType.basketball.rawValue) { result in
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
    
    // MARK: - Basketball Latest Events
    func testGetEventsBasketballLatest() {
        let expectation =  XCTestExpectation(description: "Basketball latest event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: basketballID, from: latestFrom, to: latestTo, APIkey: Token.APIKey, pathURL: SportType.basketball.rawValue) { result in
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

    // MARK: - Cricket Upcoming Events
    func testGetEventsCricketUpcoming() {
        let expectation =  XCTestExpectation(description: "Cricket upcoming event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: cricketID, from: upcomingFrom, to: upcomingTo, APIkey: Token.APIKey, pathURL: SportType.cricket.rawValue) { result in
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
    
    // MARK: - Cricket Latest Events
    func testGetEventsCricketLatest() {
        let expectation =  XCTestExpectation(description: "Cricket latest event data downloaded")
        var response: LeagueEventData?
        var error: NSError?
        sut.getEvents(met: Met.fixtures.rawValue, leagueId: cricketID, from: latestFrom, to: latestTo, APIkey: Token.APIKey, pathURL: SportType.cricket.rawValue) { result in
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
    
    
    // MARK: - Football league teams
    func testgetAllTeamsFootball() {
        let expectation =  XCTestExpectation(description: "Football league teams data downloaded")
        var response: TeamData?
        var error: NSError?
        sut.getAllTeams(met: Met.teams.rawValue, leagueId: footballID, APIkey: Token.APIKey, pathURL: SportType.football.rawValue) { result in
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
    
    // MARK: - Basketball league teams
    func testgetAllTeamsBasketball() {
        let expectation =  XCTestExpectation(description: "Basketball league teams data downloaded")
        var response: TeamData?
        var error: NSError?
        sut.getAllTeams(met: Met.teams.rawValue, leagueId: basketballID, APIkey: Token.APIKey, pathURL: SportType.basketball.rawValue) { result in
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
    
    // MARK: - Cricket league teams
    func testgetAllTeamsCricket() {
        let expectation =  XCTestExpectation(description: "Cricket league teams data downloaded")
        var response: TeamData?
        var error: NSError?
        sut.getAllTeams(met: Met.teams.rawValue, leagueId: cricketID, APIkey: Token.APIKey, pathURL: SportType.cricket.rawValue) { result in
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
    
    // MARK: - Tennis Upcoming Events
    func testgetTennisEventsUpcoming() {
        let expectation = XCTestExpectation(description: "Tennis league upcoming events")
        var error: NSError?
        var response: TennisData?
        sut.getTennisEvents(met: Met.fixtures.rawValue, leagueId: tennisID, from: upcomingFrom, to: upcomingTo, APIkey: Token.APIKey, pathURL: SportType.tennis.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    // MARK: - Tennis Latest Events
    func testgetTennisEventsLatest() {
        let expectation = XCTestExpectation(description: "Tennis league latest events")
        var error: NSError?
        var response: TennisData?
        sut.getTennisEvents(met: Met.fixtures.rawValue, leagueId: tennisID, from: latestFrom, to: latestTo, APIkey: Token.APIKey, pathURL: SportType.tennis.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
    // MARK: - Tennis League Players
    func testgetTennisPlayers() {
        let expectation =  XCTestExpectation(description: "Cricket league teams data downloaded")
        var response: TennisPlayerData?
        var error: NSError?
        sut.getTennisPlayers(met: Met.players.rawValue, leagueId: tennisID, APIkey: Token.APIKey, pathURL: SportType.tennis.rawValue) { result in
            switch result {
            case .success(let success):
                response = success
            case .failure(let failure):
                error = failure
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
    }
}
