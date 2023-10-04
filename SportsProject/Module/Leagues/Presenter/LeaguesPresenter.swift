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
    var pathURL: String

    private let apiKey = Token.APIKey
    private let met: String = "Leagues"

    // MARK: - Init
    init(view: LeaguesProtocol? = nil, pathURL: String) {
        self.view = view
        self.pathURL = pathURL
    }
    
    // MARK: Public Functions
    
    // MARK: - Configure Table View
    func getData() {
        view?.showIndicator()
        api.getLeaguesData(met: met, APIKey: apiKey, pathURL: pathURL) { [weak self] result in
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
        let title = leagues[index].leagueName ?? ""
        cell.displayLeagueTitle(title: title)
        
//        switch SportType {
//        case .basketball:
//            break
//        case .football:
//        case .cricket:
//        case .tennis:
//        }
        cell.displayLeagueImage(by: leagues[index].leagueLogo)
        
    }
    
    // MARK: - Navigation
    func didSelectRow(index: Int) {
        let leagueId = leagues[index].leagueKey
        view?.navigateToLeagueEventsScreen(pathURL: pathURL, leagueId: leagueId)
    }

    // MARK: - Private Functions
    
    
}
