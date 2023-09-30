//
//  LeaguesPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

class LeaguesPresenter {
    // MARK: - Variable
    private weak var view: LeaguesProtocol?
    private let api: LeaguesAPIProtocol = LeaguesAPI()
    var leagues: [LeaguesModel] = Array<LeaguesModel>()
    
    private let met = "Leagues"
    private let APIKey = "0537e30da2720f6e62679690742a746c3831f677ea92b00dab26a3918ecbae73"
    
    // MARK: - Init
    init(view: LeaguesProtocol? = nil) {
        self.view = view
    }
    
    // MARK: - Public Functions
    
    // MARK: - Configure Table View
    func getData() {
        view?.showIndicator()
        api.getLeaguesData(met: met, APIKey: APIKey) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideIndicator()

            switch result {
            case .success(let leaguesData):
                guard let leaguesData = leaguesData else { return }
                guard let leagues = leaguesData.result else { return }
                
                self.leagues = leagues
                self.view?.reloadLeaguesTableView()
                print(leagues.count)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getLeaguesCount() -> Int {
        return leagues.count
    }
    
    func getLeague(at row: Int) -> LeaguesModel {
        return leagues[row]
    }
    
    // MARK: - Configure Cell
    func configureCell(cell: LeaguesCellProtocol, for index: Int) {
        cell.displayLeagueTitle(title: leagues[index].leagueName ?? "")
        cell.displayLeagueImage(by: leagues[index].leagueLogo)
    }
    
    // MARK: - Navigation
    func didSelectRow(index: Int) {
        let league = leagues[index]
        view?.navigateToLeagueDetailsScreen(league: league)
    }

    // MARK: - Private Functions
    
    
}
