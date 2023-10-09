//
//  HomePresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

class HomePresenter: BasePresenter {
    
    // MARK: - Variables
    private weak var view: HomeViewProtocol? // To avoid retain cycle.
    
    private let sports = Sport.fetchSports()
    
    // MARK: - Initializer
    init(view: HomeViewProtocol? = nil) {
        self.view = view
    }
    
    // MARK: - Life cycle
    func viewDidLoad() {
        startNotification()
        handleReachability(view: view)
    }
    
    // MARK: - Collection View Data
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func configureCell(_ cell: HomeCellProtocol, for index: Int) {
        let sport = sports[index]
        cell.displaySportName(sport.name)
        cell.displaySportImage(by: sport.image)
    }
    
    func didsplaySelectItem(at index: Int) {
        let sport = sports[index].sport
        view?.navigateToLeaguesScreen(sport)
    }
    
    // MARK: - View Protocol
    func showAlert() {
        view?.showAlert()
    }
}
