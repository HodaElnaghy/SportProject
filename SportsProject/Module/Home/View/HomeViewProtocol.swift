//
//  HomeViewProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

protocol HomeViewProtocol {
    func navigateToLeaguesScreen(_ sportPathURL: String)
    func showAlert()
    func displayMessage(message: String, messageError: Bool)
//    func showAlert(_ index : Int)
}
