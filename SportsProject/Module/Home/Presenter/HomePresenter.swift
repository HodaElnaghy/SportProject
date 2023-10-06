//
//  HomePresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 01/10/2023.
//

import Foundation

class HomePresenter {
    
    // MARK: - Variables
    private var view: HomeViewProtocol?
    private var reachability: ReachabilityManager?
    private var sports = Sport.fetchSports()
    private var isConnected: Bool!
    
    
    // MARK: - Initializer
    init(view: HomeViewProtocol? = nil) {
        self.view = view
        reachability = ReachabilityManager.shared
    }
    
    
    // MARK: - Life cycle
    func viewDidLoad() {
        startNotification()
        handleReachability()
    }
    
    // MARK: - Collection View Data
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func configureCell(cell: HomeCellProtocol, for index: Int) {
        let sport = sports[index]
        cell.displaySportName(sport.name)
        cell.displaySportImage(by: sport.image)
    }
    
    func didsplaySelectItem(index: Int) {
        let sportPathURL = sports[index].pathURL
        view?.navigateToLeaguesScreen(sportPathURL)
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

    
    // MARK: - View Protocol
    func showAlert() {
        view?.showAlert()
    }
}
