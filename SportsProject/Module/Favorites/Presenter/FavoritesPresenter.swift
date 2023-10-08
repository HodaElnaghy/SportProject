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
    private var reachability: ReachabilityManager?

    private var dbManager: DataBaseManagerProtocol?
    private var items: [LeagueModelDB] = Array<LeagueModelDB>()
    private var isConnected: Bool!
    
    // MARK: - Initializer
    init(view: FavoriteLeaguesProtocol? = nil) {
        self.view = view
        dbManager = CoreDataManager()
        reachability = ReachabilityManager.shared
    }
    
    // MARK: - Life cycle
    func viewDidLoad() {
        startNotification()
        handleReachability()
        getLeaguesFromCoreData()
    }
   
    // MARK: - Connectivity
    private func startNotification() {
        print("startNotification")
        reachability?.startNotification()
    }
    
    func stopNotification() {
        print("stopNotification")
        reachability?.stopNotification()
    }
    
   private func handleReachability() {
        print("handleReachability")
        reachability?.handleReachability(completion: { [weak self] connection in
            guard let self = self else { return }
            switch connection {
            case .none:
                isConnected = false
                view?.displayMessage(message: ConnectivityMessage.noInternet, messageError: true)
            case .unavailable:
                isConnected = false
                view?.displayMessage(message: ConnectivityMessage.noInternet, messageError: true)
            case .wifi:
                isConnected = true
                view?.displayMessage(message: ConnectivityMessage.wifiConnect, messageError: false)
            case .cellular:
                isConnected = true
                view?.displayMessage(message: ConnectivityMessage.cellularConnect, messageError: false)
            }
        })
    }
    
    func isConnectedToInternet() -> Bool {
         return isConnected
    }
    
    // MARK: - Core Data
    func getLeaguesFromCoreData() {
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
    
    func configureCell(cell: LeaguesCellProtocol, for index: Int) {
        let league = items[index]
        cell.displayLeagueTitle(title: league.leagueName ?? "There is no name")
        cell.displayLeagueImage(by: league.leagueLogo ?? "person.fill")
    }
    
    
    // MARK: - Favorites View Protocol
    func didSelectRow(index: Int) {
        guard let pathURL = items[index].pathURL else { return }
        guard let leagueId = items[index].leagueId else { return }
        view?.navigateToLeagueEventsScreen(pathURL: pathURL, leagueId: leagueId)
    }
    
    func showAlert() {
        view?.showAlert()
    }
}
