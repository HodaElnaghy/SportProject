//
//  LeagueEventsModel.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation
struct LeagueEventData: Decodable {
	let success: Int?
	let result: [LeagueEventModel]?

	enum CodingKeys: String, CodingKey {
		case success, result
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Int.self, forKey: .success)
		result = try values.decodeIfPresent([LeagueEventModel].self, forKey: .result)
	}

}
