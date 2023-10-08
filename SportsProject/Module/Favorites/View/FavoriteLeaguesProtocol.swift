//
//  FavoriteLeaguesProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation

protocol FavoriteLeaguesProtocol {
    func reloadLeaguesTableView()
    func updateTableView(at indexPath: IndexPath)
    
    func showIndicator()
    func hideIndicator()
    
    func showAlert()
    func displayMessage(message: String, messageError: Bool)
    
    func navigateToLeagueEventsScreen(pathURL: String, leagueId: Int?)
    
    //    func displayMessage(message: String, messageError: Bool)
}
