//
//  FavoriteLeaguesProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation

protocol FavoriteLeaguesProtocol: AnyObject, BaseView {
    func reloadLeaguesTableView()
    func updateTableView(at indexPath: IndexPath)
    
    func showIndicator()
    func hideIndicator()
    
    func showAlertForConnectivity()
//    func displayMessage(_ message: String, theme: MessagesTheme)
    func navigateToLeagueEventsScreen(with model: CustomSportModel)
}
