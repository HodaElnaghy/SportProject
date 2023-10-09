//
//  LeaguesViewControllerProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

protocol LeaguesProtocol: AnyObject, BaseView {
    func reloadLeaguesTableView()
    func showIndicator()
    func hideIndicator()
    func showAlert()
//    func displayMessage(_ message: String, theme: MessagesTheme)
    func navigateToLeagueEventsScreen(with model: CustomSportModel)
}


