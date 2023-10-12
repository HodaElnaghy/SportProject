//
//  MockLeaguesAPI.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject


enum ResponseWithError: Error {
    case responseError
}

final class MockLeaguesAPI {
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func fetchDataFromJsonFile() -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "leaguesResponse.json", withExtension: nil) else {
            fatalError("Could not find leaguesResponse.json")
        }
        guard let leaguesData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        return leaguesData
    }
    
}

extension MockLeaguesAPI: LeaguesAPIProtocol {
    func getLeaguesData(met: String, APIKey: String, pathURL: String, completion: @escaping (Result<SportsProject.LeaguesData?, NSError>) -> Void) {
        let data = fetchDataFromJsonFile()
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError as NSError))
        } else {
            let jsonData = try? JSONDecoder().decode(LeaguesData.self, from: data)
            completion(.success(jsonData))
        }
    }
    
}
                       
