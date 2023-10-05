//
//  LeagueEventsAPIProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

protocol LeagueEventsAPIProtocol {
    
    func getUpcomingEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventsModel?, NSError>) -> Void)
    
    func getLatestResults(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventsModel?, NSError>) -> Void)
    
    func getAllTeams(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TeamData?, NSError>) -> Void)
    
}
