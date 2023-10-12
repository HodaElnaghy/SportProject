//
//  MockLeagueEventsAPI.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject


final class MockLeagueEventsAPI {
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchEventsData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "upcomingEventsResponse.json", withExtension: nil) else {
            fatalError("Could not find upcomingEventsResponse.json")
        }
        guard let leaguesData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return leaguesData // items count = 10
    }
    
    func fetchAllTeamsData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "leagueTeamsResponse.json", withExtension: nil) else {
            fatalError("Could not find leagueTeamsResponse.json")
        }
        guard let leaguesData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return leaguesData // items count = 20
    }
    
    func fetchTennisEvents() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "tennisEventsResponse.json", withExtension: nil) else {
            fatalError("Could not find tennisEventsResponse.json")
        }
        guard let leaguesData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return leaguesData // items count = 29
    }
    
    func fetchTennisPlayersData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "tennisPlayerResponse.json", withExtension: nil) else {
            fatalError("Could not find tennisPlayerResponse.json")
        }
        guard let leaguesData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return leaguesData // items count = 47
    }
}

extension MockLeagueEventsAPI: LeagueEventsAPIProtocol {
    func getEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.LeagueEventData?, NSError>) -> Void) {
        let data = fetchEventsData()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(LeagueEventData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
    func getAllTeams(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.TeamData?, NSError>) -> Void) {
        let data = fetchAllTeamsData()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(TeamData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
    func getTennisEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.TennisData?, NSError>) -> Void) {
        let data = fetchTennisEvents()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(TennisData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
    func getTennisPlayers(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.TennisPlayerData?, NSError>) -> Void) {
        let data = fetchTennisPlayersData()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(TennisPlayerData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
    
}
