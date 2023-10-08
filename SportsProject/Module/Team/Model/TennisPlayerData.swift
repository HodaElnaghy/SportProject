//
//  TennisPlayerData.swift
//  SportsProject
//
//  Created by Mohammed Adel on 07/10/2023.
//

import Foundation

struct TennisPlayerData: Decodable {
    let success: Int?
    let result: [TennisPlayerResult]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Int.self, forKey: .success)
        result = try values.decodeIfPresent([TennisPlayerResult].self, forKey: .result)
    }

}

