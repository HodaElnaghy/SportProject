//
//  TeamNetworking.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation

import Alamofire

enum TeamNetworking {
    case getTeam(met: String, teamId: Int, APIkey: String)
}

extension TeamNetworking: TargetType {
    var baseURL: String {
        return URLs.base
    }
    
    var pathURL: String {
        switch self {
            
        case .getTeam:
            return URLs.teamDetails
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .getTeam:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .getTeam(met: let met, teamId: let teamId, APIkey: let APIkey):
            return .requestParameters(parameters: ["met" : met, "teamId": teamId, "APIkey": APIkey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        case .getTeam:
            return nil
        }
    }
    
    
}
