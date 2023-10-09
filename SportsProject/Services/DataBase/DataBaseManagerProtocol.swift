//
//  DataBaseManagerProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 09/10/2023.
//

import Foundation


// MARK: - CoreData Protocol
protocol DataBaseManagerProtocol {
//    func insertLeague(_ item: LeagueModelDB, completion: () -> Void)
    func insertLeague(_ item: LeagueModelDB)
    func fetchLeagues(completion: @escaping(Result<[LeagueModelDB], Error>) -> Void)
    func fetchSingleLeague(leagueName: String, completion: @escaping(Result<LeagueModelDB, Error>) -> Void)
    func removeLeague(leagueId: Int)
    func isFavorite(leagueId: Int) -> Bool
}
