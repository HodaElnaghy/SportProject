//
//  PlayerModel.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation
struct Coaches: Decodable {
	let coachName: String?
	let coachCountry: String?
	let coachAge: String?

	enum CodingKeys: String, CodingKey {
		case coachName = "coach_name"
		case coachCountry = "coach_country"
		case coachAge = "coach_age"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		coachName = try values.decodeIfPresent(String.self, forKey: .coachName)
		coachCountry = try values.decodeIfPresent(String.self, forKey: .coachCountry)
		coachAge = try values.decodeIfPresent(String.self, forKey: .coachAge)
	}

}
