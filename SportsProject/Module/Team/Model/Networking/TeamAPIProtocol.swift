//
//  TeamAPIProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation

protocol TeamAPIProtocol {
    func getTeamData(met: String, teamId: Int, APIkey: String, pathURL: String, completion: @escaping (Result<TeamData?, NSError>) -> Void)
}
