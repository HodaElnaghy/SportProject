//
//  BasePresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 09/10/2023.
//

import Foundation


class BasePresenter { // Base presenter for connectivity

     // MARK: - Vars
    var isConnected: Bool?
    let reachability: ReachabilityManager? = ReachabilityManager.shared
    
    // MARK: - Functions
    func startNotification() {
        print("startNotification")
        reachability?.startNotification()
    }
    
    func stopNotification() {
        print("stopNotification")
        reachability?.stopNotification()
    }
    
    func handleReachability(view: BaseView?) {
        print("handleReachability")
        reachability?.handleReachability(completion: { [weak self] connection in
            guard let self = self else { return }
            switch connection {
            case .none:
                isConnected = false
                view?.displayMessage(ConnectivityMessage.noInternet, theme: .warning)
            case .unavailable:
                isConnected = false
                view?.displayMessage(ConnectivityMessage.noInternet, theme: .warning)
            case .wifi:
                isConnected = true
                view?.displayMessage(ConnectivityMessage.wifiConnect, theme: .success)
            case .cellular:
                isConnected = true
                view?.displayMessage(ConnectivityMessage.cellularConnect, theme: .success)
            }
        })
    }
    
    func isConnectedToInternet() -> Bool {
         return isConnected ?? false
    }

}
