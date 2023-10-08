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
    func showAlert()
    func displayMessage(message: String, messageError: Bool)
    func navigateToLeagueEventsScreen(pathURL: String, leagueId: Int?)
    //    func fetchingDataSuccess()
}


