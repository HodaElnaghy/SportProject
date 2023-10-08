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
    private var reachability: ReachabilityManager?
    private let api: LeaguesAPIProtocol = LeaguesAPI()
    var leagues: [LeaguesModel] = Array<LeaguesModel>()
    var pathURL: String
    private var isConnected: Bool!

    private let apiKey = Token.APIKey
    private let met: String = "Leagues"

    // MARK: - Init
    init(view: LeaguesProtocol? = nil, pathURL: String) {
        self.view = view
        self.pathURL = pathURL
        reachability = ReachabilityManager.shared
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        startNotification()
        handleReachability()
//        getData() // Call getData() inside handleReachability()
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
                if leagues.isEmpty { // to make sure it called once
                    getData()
                }
                view?.displayMessage(message: ConnectivityMessage.wifiConnect, messageError: false)
            case .cellular:
                isConnected = true
                if leagues.isEmpty {
                    getData()
                }
                view?.displayMessage(message: ConnectivityMessage.cellularConnect, messageError: false)
            }
        })
    }
    
    func isConnectedToInternet() -> Bool {
         return isConnected
    }
    
    // MARK: - Configure Table View
    private func getData() {
        print(leagues.count)
        print(isConnectedToInternet())
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
        cell.displayLeagueImage(by: leagues[index].leagueLogo)
    }
    
    // MARK: - View Protocol
    func didSelectRow(index: Int) {
        let leagueId = leagues[index].leagueKey
        view?.navigateToLeagueEventsScreen(pathURL: pathURL, leagueId: leagueId)
    }
    
    func showAlert() {
        view?.showAlert()
    }
    
}
