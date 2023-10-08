//
//  LeagueEventsAPIProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

protocol LeagueEventsAPIProtocol {
    
    func getUpcomingEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventData?, NSError>) -> Void)
    
    func getLatestResults(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<LeagueEventData?, NSError>) -> Void)
    
    func getAllTeams(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TeamData?, NSError>) -> Void)
    
    func getTennisEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String, completion: @escaping (Result<TennisData?, NSError>) -> Void)
    
    func getTennisPlayers(met: String, leagueId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TennisPlayerData?, NSError>) -> Void)
}
