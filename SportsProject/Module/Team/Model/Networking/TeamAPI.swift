//
//  TeamAPI.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation

class TeamAPI: BaseAPI<TeamNetworking>, TeamAPIProtocol {
    
    func getTeamData(met: String, teamId: Int, APIkey: String, completion: @escaping (Result<TeamData?, NSError>) -> Void) {
        fetchData(target: .getTeam(met: met, teamId: teamId, APIkey: APIkey), model: TeamData.self) { result in
            switch result {
            case .success(let teamData):
                print(teamData?.success ?? 99)
                completion(.success(teamData))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
