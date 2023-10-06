//
//  EventModelDB.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation


struct EventModelDB {
    let eventKey: Int?
    let eventAwayTeam: String?
    let leagueName: String?
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    
    let players : [PlayerModelDB]?
    let coaches : [TeamModelDB]?
}
