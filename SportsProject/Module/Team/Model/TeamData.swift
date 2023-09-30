//
//  TeamData.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation
struct TeamData : Codable {
	let success : Int?
	let result : [TeamResult]?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case result = "result"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Int.self, forKey: .success)
		result = try values.decodeIfPresent([TeamResult].self, forKey: .result)
	}

}
