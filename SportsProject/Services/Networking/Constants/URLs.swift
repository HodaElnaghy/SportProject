//
//  URLs.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

struct URLs {
    static let base = "https://apiv2.allsportsapi.com"
  
    
    // https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=[YourKey]
    // get all leagues
    /// GET{met, APIkey}
    static let getLeaguess = "/football/"

    // Get upcoming events
    // https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate]&to=[CurrentDate + OneYear]&APIkey=[YourKey]
    // https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=[YourKey]
    // GET{met, leagueId, from, to, APIkey}
    static let upComingEvents = "/football/"
    
    
    // Get Latest Results :
    // https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=[YourKey]
    // https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2022-01-18&to=2023-01-18&APIkey=[YourKey]
    /// GET{met, leagueId, from, to, APIkey}
    static let latestResults = "/football/"

    
    // Basketball
    //https://apiv2.allsportsapi.com/basketball/
    static let basketball = "/basketball/"
    
    // Cricket
    //https://apiv2.allsportsapi.com/cricket/
    static let cricket = "/cricket/"
}
