//
//  LeaguesNetworking.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation
import Alamofire

enum LeaguesNetworking {
    case getLeagues(met: String, APIKey: String)
}

extension LeaguesNetworking: TargetType {
    var baseURL: String {
        return URLs.base
    }
    
    var pathURL: String {
        switch self {
        case .getLeagues:
            return URLs.getLeaguess
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLeagues:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getLeagues(let met, let APIKey):
            return .requestParameters(parameters: ["met" : met, "APIkey": APIKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getLeagues:
            return [:]
        }
    }
    
    
}
