//
//  MockTeamAPITest.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject

final class MockTeamAPITest: XCTestCase {

    var sut: MockTeamAPI!
    
    override func setUpWithError() throws {
       sut = MockTeamAPI(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetTeamData () {
        let predicatedPlayersCount = 34
        let predicatedCoachName = "I. Juric"
        let predicatedTeamName = "Torino"
        let predicatedTeamKey = 4973
        
        var teamResult: [TeamResult]?
        var playersCount: Int?
        var coachName: String?
        var teamName: String?
        var teamKey: Int?
        var error: NSError?
        sut.getTeamData(met: "", teamId: 1, APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                teamResult = success?.result
                playersCount = success?.result?[0].players?.count
                coachName = success?.result?[0].coaches?[0].coachName
                teamName = success?.result?[0].teamName
                teamKey = success?.result?[0].teamKey
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertNotNil(teamResult)
        XCTAssertEqual(playersCount, predicatedPlayersCount, "Team players count equal 34")
        XCTAssertEqual(coachName, predicatedCoachName, "Team coach name is I. Juric")
        XCTAssertEqual(teamName, predicatedTeamName, "Team name is Torino")
        XCTAssertEqual(teamKey, predicatedTeamKey, "Team key equal 4973")
    }
    
    func testGetPlayerData () {
        let predicatedPlayersName = "N. Djokovic"
        let predicatedPlayerKey = 1905

        var playerName: String?
        var playerKey: Int?
        var data: TennisPlayerData?
        var error: NSError?
        
        sut.getPlayerData(met: "", teamId: 1, APIkey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                data = success
                playerName = data?.result?[0].playerName
                playerKey = data?.result?[0].playerKey
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertNotNil(data)
        XCTAssertEqual(playerName, predicatedPlayersName, "Team players count equal 34")
        XCTAssertEqual(playerKey, predicatedPlayerKey, "Team players count equal 38")
    }
    
}
