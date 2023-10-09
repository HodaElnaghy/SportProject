//
//  LeagueEventData.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

struct LeagueEventModel: Decodable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let eventFinalResult: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let leagueLogo: String?
    let leagueName: String?
    let eventStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventFinalResult = "event_final_result"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case leagueLogo = "league_logo"
        case leagueName = "league_name"
        case eventStatus = "event_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventKey = try values.decodeIfPresent(Int.self, forKey: .eventKey)
        eventDate = try values.decodeIfPresent(String.self, forKey: .eventDate)
        eventTime = try values.decodeIfPresent(String.self, forKey: .eventTime)
        eventHomeTeam = try values.decodeIfPresent(String.self, forKey: .eventHomeTeam)
        eventAwayTeam = try values.decodeIfPresent(String.self, forKey: .eventAwayTeam)
        eventFinalResult = try values.decodeIfPresent(String.self, forKey: .eventFinalResult)
        homeTeamLogo = try values.decodeIfPresent(String.self, forKey: .homeTeamLogo)
        awayTeamLogo = try values.decodeIfPresent(String.self, forKey: .awayTeamLogo)
        leagueLogo = try values.decodeIfPresent(String.self, forKey: .leagueLogo)
        leagueName = try values.decodeIfPresent(String.self, forKey: .leagueName)
        eventStatus = try values.decodeIfPresent(String.self, forKey: .eventStatus)
    }
    
}
