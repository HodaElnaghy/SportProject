//
//  LeagueCustomCellProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

protocol LeagueCustomCellProtocol: AnyObject {
    
    func displayEventAwayTeamName(_ name: String)
    func displayEventHomeTeamName(_ name: String)
    
    func displayFinalResult(_ result: String)
    func diaplayEventTime(_ time: String)
    func diaplayEventDate(_ date: String)
    
    func displayEventState(_ state: String)

    func displayHomeTeamImage(by stringURL: String?)
    func displayAwayTeamImage(by stringURL: String?)
}
