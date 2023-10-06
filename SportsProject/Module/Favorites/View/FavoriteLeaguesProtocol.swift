//
//  FavoriteLeaguesProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation

protocol FavoriteLeaguesProtocol {
    func reloadLeaguesTableView()
    func showIndicator()
    func hideIndicator()
//    func displayMessage(message: String, messageError: Bool)
    
    func showAlert()
    func navigateToLeagueEventsScreen(pathURL: String, leagueId: Int?)
}
