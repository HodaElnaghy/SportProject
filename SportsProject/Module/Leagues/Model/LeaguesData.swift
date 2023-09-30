//
//  LeaguesData.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation
struct LeaguesData: Codable {
	let success: Int?
	let result: [LeaguesModel]?

	enum CodingKeys: String, CodingKey {
//		case success = "success"
//		case result = "result"
        case success, result
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Int.self, forKey: .success)
		result = try values.decodeIfPresent([LeaguesModel].self, forKey: .result)
	}

}
