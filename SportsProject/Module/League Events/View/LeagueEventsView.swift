//
//  LeagueEventsView.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

protocol LeagueEventsView: AnyObject, BaseView {
//    func ShowIndicator()
//    func HideIndicator()
    func reloadCollectionView()
    func showAlert()
    func displayMessage(_ message: String, theme: MessagesTheme)
    func navigateToTeamScreen(pathURL: String, teamId: Int?)
    func showAlertNotAllowedToNavigate()
}

//protocol FavoriteDelegate {
//    func updateTableViewData()
//}
