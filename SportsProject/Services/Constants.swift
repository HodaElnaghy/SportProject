//
//  ErrorMessage.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

struct ErrorMessage {
    static let genericError = "Some Thing going wrong, Please try again later."
}

struct ConnectivityMessage {
    static let alertTitle = "No internet connection!"
    static let alertMessage = "Please connect to the internet and try again."
    
    static let noInternet = "No internet connection!"
    static let wifiConnect = "Connected by wifi"
    static let cellularConnect = "Connected by cellular"
}

struct BackendMessage {
    static let alertTitle = "500"
    static let alertMessage = "Some Thing going wrong, Please try again later."
}


struct CellIdentifier {
    static let LeaguesCelll = "LeaguesCell"
    static let HomeCustomCell = "HomeCustomCell"
    static let LeagueCustomCell = "LeagueCustomCell"
    static let TeamCustomCell = "TeamCustomCell"
    static let EmptyCell = "EmptyCell"
}


struct VCIdentifier {
    static let LeaguesViewController = "LeaguesViewController"
    static let LeagueEventsViewController =  "LeagueEventsViewController"
    static let TeamViewController = "TeamViewController"
    
}

