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
    let api: LeaguesAPIProtocol = LeaguesAPI()
    var leagues: [LeaguesModel] = []
    
    private let met = "Leagues"
    private let APIKey = "0537e30da2720f6e62679690742a746c3831f677ea92b00dab26a3918ecbae73"
    
    // MARK: - Init
    init(view: LeaguesProtocol? = nil) {
        self.view = view
    }
    
    // MARK: - Public Functions
    
    func getData() {
        api.getLeaguesData(met: met, APIKey: APIKey) { result in
            //guard let self = self else { return }
            switch result {
                
            case .success(let leagues):
                guard let leagues = leagues else { return }
                self.leagues = leagues
                print(leagues.count)
                for i in leagues {
                    print(i.league_name ?? "NOT Found Name")
                }
                
                self.view?.reloadLeaguesTableView()
               
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

    
//    func configure(cell: UserCellView, for index: Int) {
//        let user = users[index]
//        cell.displayName(name: user._name)
//        cell.displayEmail(email: user._email)
//        cell.displayAddress(address: "\(user._address._street) \(user._address._suite)")
//    }
//    
//    func didSelectRow(index: Int) {
//        let user = users[index]
//        view?.navigateToUserDetailsScreen(user: user)
//    }
    
    // MARK: - Private Functions
    
    
}
