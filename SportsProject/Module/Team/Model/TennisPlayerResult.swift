//
//  TennisPlayerResult.swift
//  SportsProject
//
//  Created by Mohammed Adel on 07/10/2023.
//

import Foundation
struct TennisPlayerResult: Decodable {
	let playerKey : Int?
	let playerName : String?
	let playerLogo : String?

	enum CodingKeys: String, CodingKey {
		case playerKey = "player_key"
		case playerName = "player_name"
		case playerLogo = "player_logo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        playerKey = try values.decodeIfPresent(Int.self, forKey: .playerKey)
        playerName = try values.decodeIfPresent(String.self, forKey: .playerName)
        playerLogo = try values.decodeIfPresent(String.self, forKey: .playerLogo)
	}

}
