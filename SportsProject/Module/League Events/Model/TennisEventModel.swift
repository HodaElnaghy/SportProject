//
//  TennisEventModel.swift
//  SportsProject
//
//  Created by Mohammed Adel on 07/10/2023.
//

import Foundation

struct TennisEventModel: Decodable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
	let eventFirstPlayer: String?
	let firstPlayerKey: Int?
	let eventSecondPlayer: String?
	let secondPlayerKey: Int?
	let eventFinalResult: String?
	let eventStatus: String?
	let leagueName: String?
    let leagueKey: Int?
	let eventFirstPlayerLogo: String?
	let eventSecondPlayerLogo: String?
	
    
	enum CodingKeys: String, CodingKey {
		case eventKey = "event_key"
		case eventDate = "event_date"
		case eventTime = "event_time"
		case eventFirstPlayer = "event_first_player"
		case firstPlayerKey = "first_player_key"
		case eventSecondPlayer = "event_second_player"
		case secondPlayerKey = "second_player_key"
		case eventFinalResult = "event_final_result"
		case eventStatus = "event_status"
		case leagueName = "league_name"
		case leagueKey = "league_key"
		case eventFirstPlayerLogo = "event_first_player_logo"
		case eventSecondPlayerLogo = "event_second_player_logo"
	}

	init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventKey = try values.decodeIfPresent(Int.self, forKey: .eventKey)
        eventDate = try values.decodeIfPresent(String.self, forKey: .eventDate)
        eventTime = try values.decodeIfPresent(String.self, forKey: .eventTime)
        eventFirstPlayer = try values.decodeIfPresent(String.self, forKey: .eventFirstPlayer)
        firstPlayerKey = try values.decodeIfPresent(Int.self, forKey: .firstPlayerKey)
        eventSecondPlayer = try values.decodeIfPresent(String.self, forKey: .eventSecondPlayer)
        secondPlayerKey = try values.decodeIfPresent(Int.self, forKey: .secondPlayerKey)
        eventFinalResult = try values.decodeIfPresent(String.self, forKey: .eventFinalResult)
        eventStatus = try values.decodeIfPresent(String.self, forKey: .eventStatus)
        leagueName = try values.decodeIfPresent(String.self, forKey: .leagueName)
        leagueKey = try values.decodeIfPresent(Int.self, forKey: .leagueKey)
        eventFirstPlayerLogo = try values.decodeIfPresent(String.self, forKey: .eventFirstPlayerLogo)
        eventSecondPlayerLogo = try values.decodeIfPresent(String.self, forKey: .eventSecondPlayerLogo)
	}

}
