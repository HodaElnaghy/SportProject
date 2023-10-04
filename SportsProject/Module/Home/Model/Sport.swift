//
//  HomeModel.swift
//  SportsProject
//
//  Created by Hend on 27/09/2023.
//

import Foundation


struct Sport {
    let id: Int
    let name: String
    let image: String
    let pathURL: String
    
    static func fetchSports() -> [Sport] {
        let sports = [
            Sport(id: 0, name: "Soccer", image: "soccer", pathURL: URLs.football),
            Sport(id: 1, name: "BasketBall", image: "basketBall", pathURL: URLs.basketball),
            Sport(id: 2, name: "Cricket", image: "cricket", pathURL: URLs.cricket),
            Sport(id: 3, name: "Tennis", image: "tennis", pathURL: URLs.tennis)
        ]
        
        return sports
    }
    
}
