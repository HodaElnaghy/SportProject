//
//  LeagueEventsAPI.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

class LeagueEventsAPI: BaseAPI<LeagueEventsNetworking>, LeagueEventsAPIProtocol {
    
    // MARK: - Football, Basketball, Cricket
    func getUpcomingEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventData?, NSError>) -> Void) {
        fetchData(target: .getUpcomingEvents(met: met, leagueId: leagueId, from: from, to: to, APIkey: APIkey, pathURL: pathURL), model: LeagueEventData.self) { result in
            switch result {
            case .success(let leagueEventsModel):
                //print(leagueEventsModel?.success ?? 99)
                completion(.success(leagueEventsModel))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getLatestResults(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventData?, NSError>) -> Void) {
        fetchData(target: .getLatestResults(met: met, leagueId: leagueId, from: from, to: to, APIkey: APIkey, pathURL: pathURL), model: LeagueEventData.self) { result in
            switch result {
            case .success(let leagueLatestResults):
//                print(leagueLatestResults?.success ?? 99)
                completion(.success(leagueLatestResults))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getAllTeams(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TeamData?, NSError>) -> Void) {
        fetchData(target: .getTeams(met: met, leagueId: leagueId, APIkey: APIkey, pathURL: pathURL), model: TeamData.self) { result in
            switch result {
            case .success(let allTeamsData):
//                print(allTeamsData?.success ?? 99)
                completion(.success(allTeamsData))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Tennis
    func getTennisEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<TennisData?, NSError>) -> Void) {
        fetchData(target: .getUpcomingEvents(met: met, leagueId: leagueId, from: from, to: to, APIkey: APIkey, pathURL: pathURL), model: TennisData.self) { res in
            switch res {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTennisPlayers(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TennisPlayerData?, NSError>) -> Void) {
        // getTeams has the params, to get tennisPlayers
        fetchData(target: .getTeams(met: met, leagueId: leagueId, APIkey: APIkey, pathURL: pathURL), model: TennisPlayerData.self) { res in
            switch res {
            case .success(let playersData):
                completion(.success(playersData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
  
    
}
