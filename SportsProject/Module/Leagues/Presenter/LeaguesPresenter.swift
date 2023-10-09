//
//  LeaguesPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 27/09/2023.
//

import Foundation

class LeaguesPresenter: BasePresenter {
    // MARK: - Variable
    private weak var view: LeaguesProtocol?
    private let api: LeaguesAPIProtocol = LeaguesAPI()
    var leagues: [LeaguesModel] = Array<LeaguesModel>()

    var sport: SportType
    private let apiKey = Token.APIKey

    // MARK: - Init
    init(view: LeaguesProtocol? = nil, sport: SportType) {
        self.view = view
        self.sport = sport
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        startNotification()
        handleReachability(view: view)
        getData()
//        getData() // Call getData() inside handleReachability()
    }
    
    // MARK: - Connectivity

//   private func handleReachability() {
//        print("handleReachability")
//        reachability?.handleReachability(completion: { [weak self] connection in
//            guard let self = self else { return }
//            switch connection {
//            case .none:
//                isConnected = false
//                view?.displayMessage(ConnectivityMessage.noInternet, theme: .warning)
//            case .unavailable:
//                isConnected = false
//                view?.displayMessage(ConnectivityMessage.noInternet, theme: .warning)
//            case .wifi:
//                isConnected = true
//                if leagues.isEmpty { // to make sure it called once
//                    getData()
//                }
//                view?.displayMessage(ConnectivityMessage.wifiConnect, theme: .success)
//            case .cellular:
//                isConnected = true
//                if leagues.isEmpty {
//                    getData()
//                }
//                view?.displayMessage(ConnectivityMessage.cellularConnect, theme: .success)
//            }
//        })
//    }

    
    // MARK: - Configure Table View
    private func getData() {
        print(leagues.count)
        //print(isConnectedToInternet())
        view?.showIndicator()
        print(sport.rawValue)
        api.getLeaguesData(met: Met.leagues.rawValue, APIKey: apiKey, pathURL: sport.rawValue) { [weak self] result in
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
        let league = leagues[index]
        cell.displayLeagueTitle(title: league.leagueName ?? "")
        cell.displayLeagueImage(by: league.leagueLogo)
    }
    
    // MARK: - View Protocol
    func didSelectRow(index: Int) {
        let league = leagues[index]
        let leagueId = league.leagueKey
        let leagueName = league.leagueName
        let leagueLogo = league.leagueLogo
        let model = CustomSportModel(leagueKey: leagueId, leagueName: leagueName, leagueLogo: leagueLogo, sport: sport)
        
        view?.navigateToLeagueEventsScreen(with: model)
    }
    
    func showAlert() {
        view?.showAlert()
    }
    
}
