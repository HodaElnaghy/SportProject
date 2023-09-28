//
//  LeaguesData.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

/*
{
    "success": 1,
    "result": [
        {
            "league_key": 4,
            "league_name": "UEFA Europa League",
            "country_key": 1,
            "country_name": "eurocups",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
            "country_logo": null
        },.....
        
}
*/

struct LeaguesData: Decodable {
    let success: Int?
    let result: [LeaguesModel]?
}
