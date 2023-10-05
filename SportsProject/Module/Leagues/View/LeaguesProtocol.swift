//
//  LeaguesViewControllerProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

protocol LeaguesProtocol: AnyObject {
    func reloadLeaguesTableView()
    func showIndicator()
    func hideIndicator()
//    func fetchingDataSuccess()
//    func showError(error: String)
    func navigateToLeagueEventsScreen(pathURL: String, leagueId: Int?)
}


