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
    let sport: SportType
    
    static func fetchSports() -> [Sport] {
        let sports = [
            Sport(id: 0, name: "Soccer", image: "soccer", sport: .football),
            Sport(id: 1, name: "BasketBall", image: "basketBall", sport: .basketball),
            Sport(id: 2, name: "Cricket", image: "cricket", sport: .cricket),
            Sport(id: 3, name: "Tennis", image: "tennis", sport: .tennis)
        ]
        return sports
    }
}
