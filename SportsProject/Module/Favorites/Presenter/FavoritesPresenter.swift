//
//  FavoritesPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation

class FavoritesPresenter {
    // MARK: - Variables
    private var view: FavoriteLeaguesProtocol?
    private var dbManager: DataBaseManagerProtocol?
    private var items: [LeagueModelDB] = Array<LeagueModelDB>()
    
    
    // MARK: - Initializer
    init(view: FavoriteLeaguesProtocol? = nil) {
        self.view = view
        dbManager = CoreDataManager()
    }
    
    
    // MARK: - Life cycle
    func viewDidLoad() {
        getLeaguesFromCoreData()
    }
    
    // MARK: - Core Data
    func getLeaguesFromCoreData() {
        view?.showIndicator()
        dbManager?.fetchLeagues(completionHandler: { [weak self] result in
            guard let self = self else { return }
            view?.hideIndicator()
            switch result {
            case .success(let data):
                items = data
                view?.reloadLeaguesTableView()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    // MARK: - Collection View Data
    func getLeaguesCount() -> Int {
        print("Leagues Count: \(items.count)")
        return items.count
    }
    
    func configureCell(cell: LeaguesCellProtocol, for index: Int) {
        let league = items[index]
        cell.displayLeagueTitle(title: league.leagueName ?? "There is no name")
        cell.displayLeagueImage(by: league.leagueLogo ?? "person.fill")
    }
    
    func didsplaySelectItem(index: Int) {
        let pathURL = items[index].pathURL
        let leagueId = items[index].leagueId
        view?.navigateToLeagueEventsScreen(pathURL: pathURL ?? "", leagueId: leagueId ?? 0)
    }
    
    
    // MARK: - View Protocol
    func showAlert() {
        view?.showAlert()
    }
}
