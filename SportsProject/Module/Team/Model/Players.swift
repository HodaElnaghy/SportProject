//
//  Players.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation


struct Players : Codable {
    
	let playerKey : Int?
	let playerImage : String?
	let playerName : String?
	let playerNumber : String?
	let playerCountry : String?
    let playerType: String?
	let playerAge : String?
	let playerMatchPlayed : String?
	let playerRating : String?

	enum CodingKeys: String, CodingKey {

		case playerKey = "player_key"
		case playerImage = "player_image"
		case playerName = "player_name"
		case playerNumber = "player_number"
		case playerCountry = "player_country"
        case playerType = "player_type"
		case playerAge = "player_age"
		case playerMatchPlayed = "player_match_played"
		case playerRating = "player_rating"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        playerKey = try values.decodeIfPresent(Int.self, forKey: .playerKey)
        playerImage = try values.decodeIfPresent(String.self, forKey: .playerImage)
        playerName = try values.decodeIfPresent(String.self, forKey: .playerName)
        playerNumber = try values.decodeIfPresent(String.self, forKey: .playerNumber)
        playerCountry = try values.decodeIfPresent(String.self, forKey: .playerCountry)
        playerType = try values.decodeIfPresent(String.self, forKey: .playerType)
        playerAge = try values.decodeIfPresent(String.self, forKey: .playerAge)
        playerMatchPlayed = try values.decodeIfPresent(String.self, forKey: .playerMatchPlayed)
        playerRating = try values.decodeIfPresent(String.self, forKey: .playerRating)
	}

}