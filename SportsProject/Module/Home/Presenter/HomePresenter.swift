//
//  HomePresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

class HomePresenter {
    
    // MARK: - Variables
    var view: HomeViewProtocol?
    var sports = Sport.fetchSports()
    
    // MARK: - Initializer
    init(view: HomeViewProtocol? = nil) {
        self.view = view
    }
    
    
    // MARK: - Functions
    
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func configureCell(cell: HomeCellProtocol, for index: Int) {
        let sport = sports[index]
        cell.displaySportName(sport.name)
        cell.displaySportImage(by: sport.image)
    }
    
    func displaySelectItem(index: Int) {
        let sportPathURL = sports[index].pathURL
        view?.navigateToLeaguesScreen(sportPathURL)
    }
}
