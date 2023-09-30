//
//  Result.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation


struct TeamResult : Codable {
	let teamKey : Int?
	let teamName : String?
	let teamLogo : String?
	let players : [Players]?
	let coaches : [Coaches]?

	enum CodingKeys: String, CodingKey {

		case teamKey = "team_key"
		case teamName = "team_name"
		case teamLogo = "team_logo"
//		case players = "players"
//		case coaches = "coaches"
        case players, coaches
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        teamKey = try values.decodeIfPresent(Int.self, forKey: .teamKey)
        teamName = try values.decodeIfPresent(String.self, forKey: .teamName)
        teamLogo = try values.decodeIfPresent(String.self, forKey: .teamLogo)
		players = try values.decodeIfPresent([Players].self, forKey: .players)
		coaches = try values.decodeIfPresent([Coaches].self, forKey: .coaches)
	}

}
