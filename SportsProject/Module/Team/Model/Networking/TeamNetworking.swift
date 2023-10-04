//
//  TeamNetworking.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation

import Alamofire

enum TeamNetworking {
    case getTeam(met: String, teamId: Int, APIkey: String, pathURL: String)
}

extension TeamNetworking: TargetType {
    var baseURL: String {
        return URLs.base
    }
    
    var pathURL: String {
        switch self {
        case .getTeam(_, _, _, let pathURL):
            return pathURL
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
            
        case .getTeam(met: let met, teamId: let teamId, APIkey: let APIkey, _):
            return .requestParameters(parameters: ["met" : met, "teamId": teamId, "APIkey": APIkey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
}
