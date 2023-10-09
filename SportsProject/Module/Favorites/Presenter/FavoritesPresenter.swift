//
//  FavoritesPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 06/10/2023.
//

import Foundation

class FavoritesPresenter: BasePresenter {
    // MARK: - Variables
    private weak var view: FavoriteLeaguesProtocol?
    private let dbManager: DataBaseManagerProtocol?
    
    private var items: [LeagueModelDB] = Array<LeagueModelDB>()
    
    // MARK: - Initializer
    init(view: FavoriteLeaguesProtocol? = nil) {
        self.view = view
        dbManager = CoreDataManager()
    }
    
    // MARK: - Life cycle
    func viewDidLoad() {
        startNotification()
        handleReachability(view: view)
        getLeaguesFromCoreData()
    }
   
    // MARK: - Core Data
    private func getLeaguesFromCoreData() {
        view?.showIndicator()
        dbManager?.fetchLeagues(completion: { [weak self] result in
            guard let self = self else { return }
            view?.hideIndicator()
            switch result {
            case .success(let data):
                print("data Count from favorites: \(data.count)")
                items = data
                view?.reloadLeaguesTableView()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func removeLeagueFromCoreData(at index: Int) {
        guard let leagueId = items[index].leagueId else { return }
        dbManager?.removeLeague(leagueId: leagueId) // remove from coredata, update coredata
        items.remove(at: index) // remove from items, update items array
    }
    
    func updateTableView(at indexPath: IndexPath) {
        view?.updateTableView(at: indexPath)
    }
    
    // MARK: - Collection View Data
    func getLeaguesCount() -> Int {
        print("Leagues Count: \(items.count)")
        return items.count
    }
    
    func configureCell(_ cell: LeaguesCellProtocol, for index: Int) {
        let league = items[index]
        cell.displayLeagueTitle(title: league.leagueName ?? "")
        cell.displayLeagueImage(by: league.leagueLogo)
    }
    
    // MARK: - Favorites View Protocol
    func didSelectRow(at index: Int) {
        let league = items[index]
        let leagueId = league.leagueId
        let leagueName = league.leagueName
        let leagueLogo = league.leagueLogo
        let sport = SportType(rawValue: league.pathURL ?? "")
        let model = CustomSportModel(leagueKey: leagueId, leagueName: leagueName, leagueLogo: leagueLogo, sport: sport!)
        view?.navigateToLeagueEventsScreen(with: model)
    }
    
    func showAlertForConnectivity() {
        view?.showAlertForConnectivity()
    }
}
