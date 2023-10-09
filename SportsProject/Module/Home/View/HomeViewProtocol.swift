//
//  HomeViewProtocol.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

protocol HomeViewProtocol: AnyObject, BaseView {
    func navigateToLeaguesScreen(_ sport: SportType)
    func showAlert()
}
