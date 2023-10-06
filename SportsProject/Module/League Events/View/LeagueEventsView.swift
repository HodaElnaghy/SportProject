//
//  LeagueEventsView.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

protocol LeagueEventsView: AnyObject {
//    func ShowIndicator()
//    func HideIndicator()
    func reloadCollectionView()
    func showAlert()
    func displayMessage(message: String, messageError: Bool)
    func navigateToTeamScreen(pathURL: String, teamId: Int?)
}
