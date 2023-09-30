//
//  LeagueModelDB.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

struct LeagueModelDB {
    let leagueKey: Int?
    let leagueName: String?
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    
    let players : [PlayerModelDB]?
    let coaches : [TeamModelDB]?
}
