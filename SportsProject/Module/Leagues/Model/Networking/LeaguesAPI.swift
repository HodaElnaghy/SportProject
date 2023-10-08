//
//  LeaguesAPI.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

class LeaguesAPI: BaseAPI<LeaguesNetworking>, LeaguesAPIProtocol {
    
    func getLeaguesData(met: String, APIKey: String, pathURL: String, completion: @escaping (Result<LeaguesData?, NSError>) -> Void) {
        fetchData(target: .getLeagues(met: met, APIKey: APIKey, pathURL: pathURL), model: LeaguesData.self) { result in
            switch result {
                
            case .success(let value):
//                let leagues = value?.success
                print(value?.success ?? 99)
                completion(.success(value))
               
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
