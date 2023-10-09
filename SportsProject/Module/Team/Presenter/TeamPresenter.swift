//
//  TeamPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 29/09/2023.
//

import Foundation


class TeamPresenter {
    
    // MARK: - Variable
    private weak var view: TeamViewControllerProtocol?
//    private var cellView: TeamCellProtocol?
    
    private let api: TeamAPIProtocol = TeamAPI()
    private var teamResult: [TeamResult] = Array<TeamResult>()
    
    private var players: [Players] = []
    private var coaches: [Coaches] = []
    
    private var tennisPlayers = [TennisPlayerResult]()
    
    private let pathURL: String!
    private let teamId: Int?
    
    private let metPlayer: Met = .players
    private let metTeams: Met = .teams
    private let APIkey = Token.APIKey
//    private let url = URLs.teamDetails
    
    // MARK: - Init
    init(view: TeamViewControllerProtocol? = nil, pathURL: String, teamId: Int?) {
        self.view = view
        self.pathURL = pathURL
        self.teamId = teamId
    }

        
    // MARK: - Configure Controller
    func getData() {
        view?.showIndicator()
        guard let teamId = teamId else { return }
        api.getTeamData(met: metTeams.rawValue, teamId: teamId, APIkey: APIkey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            view?.hideIndicator()
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let result = data.result else { return }
                teamResult = result
                
                guard let players = result[0].players else { return }
                self.players = players
                
                guard let  coaches = result[0].coaches else { return }
                self.coaches = coaches
                                
                view?.reloadCollectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPlayer() {
        view?.showIndicator()
        guard let teamId = teamId else { return }
        api.getPlayerData(met: metPlayer.rawValue, teamId: teamId, APIkey: APIkey, pathURL: pathURL) { [weak self] res in
            guard let self = self else { return }
            view?.hideIndicator()
            
            switch res {
            case .success(let data):
                guard let player = data?.result else { return }
                tennisPlayers = player
                view?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTeamsCount() -> Int {
        return players.count
    }
    
    func getPlayer(at row: Int) -> Players {
        return players[row]
    }
    
    func getCoachName() -> String? {
        return coaches.first?.coachName
    }
    
    func getTeamName() -> String? {
        return teamResult.first?.teamName
    }
    
    func getTeamLog() -> String? {
        return teamResult.first?.teamLogo
    }
    
    // MARK: - Configure Cell
    func configureCell(cell: TeamCellProtocol, for index: Int) {
        let player = players[index]
        cell.displayNumber(number: player.playerNumber ?? "")
        cell.displayName(name: player.playerName ?? "")
        cell.displayType(type: player.playerType ?? "")
        cell.displayRating(rating: player.playerRating ?? "")
        cell.displayImage(by: player.playerImage)
    }
}
