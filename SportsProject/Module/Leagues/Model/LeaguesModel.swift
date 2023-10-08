//
//  LeaguesModel.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation
struct LeaguesModel: Codable {
	let leagueKey : Int?
	let leagueName : String?
	let countryKey : Int?
	let countryName : String?
	let leagueLogo : String?
	let countryLogo : String?

	enum CodingKeys: String, CodingKey {
		case leagueKey = "league_key"
		case leagueName = "league_name"
		case countryKey = "country_key"
		case countryName = "country_name"
		case leagueLogo = "league_logo"
		case countryLogo = "country_logo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        leagueKey = try values.decodeIfPresent(Int.self, forKey: .leagueKey)
        leagueName = try values.decodeIfPresent(String.self, forKey: .leagueName)
        countryKey = try values.decodeIfPresent(Int.self, forKey: .countryKey)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        leagueLogo = try values.decodeIfPresent(String.self, forKey: .leagueLogo)
        countryLogo = try values.decodeIfPresent(String.self, forKey: .countryLogo)
	}

}
