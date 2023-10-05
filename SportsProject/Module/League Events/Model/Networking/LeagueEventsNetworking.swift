//
//  LeagueEventsNetworking.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation
import Alamofire

enum LeagueEventsNetworking {
    case getUpcomingEvents(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String)
    case getLatestResults(met: String, leagueId: Int, from: String, to: String, APIkey: String, pathURL: String)
    case getTeams(met: String, leagueId: Int, APIkey: String, pathURL: String)
}

extension LeagueEventsNetworking: TargetType {
    var baseURL: String {
        return URLs.base
    }
    
    var pathURL: String {
        switch self {
        case .getUpcomingEvents(_, _, _, _, _, let pathURL):
            return pathURL
        case .getLatestResults(_, _, _, _, _, let pathURL):
            return pathURL
        case .getTeams(_, _, _, let pathURL):
            return pathURL
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getUpcomingEvents(let met, let leagueId, let from, let to, let APIkey, _):
            return .requestParameters(parameters: ["met" : met, "leagueId": leagueId, "from": from, "to": to, "APIkey": APIkey], encoding: URLEncoding.default)
        case .getLatestResults(let met, let leagueId, let from, let to, let APIkey, _):
            return .requestParameters(parameters: ["met" : met, "leagueId": leagueId, "from": from, "to": to, "APIkey": APIkey], encoding: URLEncoding.default)
        case .getTeams(let met, let leagueId, let APIkey, _):
            return .requestParameters(parameters: ["met" : met, "leagueId": leagueId, "APIkey": APIkey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

