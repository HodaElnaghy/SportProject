//
//  LeaguesAPIProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

protocol LeaguesAPIProtocol: AnyObject {
    func getLeaguesData(met: String, APIKey: String, completion: @escaping (Result<[LeaguesModel]?, NSError>) -> Void)
}
