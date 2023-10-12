//
//  MockTeamAPI.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject

final class MockTeamAPI {

    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func fetchTeamDetailsData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "TeamDetailsResponse.json", withExtension: nil) else {
            fatalError("Couldn't find TeamDetailsResponse.json")
        }
        guard let data = try? Data.init(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return data  // players count 34
    }
    
    func fetchTennisPlayerDetailsData() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "tennisPlayerDetailsResponse.json", withExtension: nil) else {
            fatalError("Couldn't find tennisPlayerDetailsResponse.json")
        }
        guard let data = try? Data.init(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return data // tournaments: 96, stats: 45, player_name: "N. Djokovic"
    }
}

extension MockTeamAPI: TeamAPIProtocol {
    func getTeamData(met: String, teamId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.TeamData?, NSError>) -> Void) {
        let data = fetchTeamDetailsData()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(TeamData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
    func getPlayerData(met: String, teamId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<SportsProject.TennisPlayerData?, NSError>) -> Void) {
        let data = fetchTennisPlayerDetailsData()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(TennisPlayerData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
}
