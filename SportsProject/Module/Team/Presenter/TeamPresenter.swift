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
//    private var players: [Players] = Array<Players>()
//    private var coaches: [Coaches] = Array<Coaches>()
    private var players: [Players] = []
    private var coaches: [Coaches] = []
    
    // https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=96&APIkey=0537e30da2720f6e62679690742a746c3831f677ea92b00dab26a3918ecbae73
    var met = "Teams"
    var teamId: Int = 96
    var APIkey = "0537e30da2720f6e62679690742a746c3831f677ea92b00dab26a3918ecbae73"
    
    let url = URLs.teamDetails
    
    // MARK: - Init
    init(view: TeamViewControllerProtocol? = nil) {
        self.view = view
    }
    
//    init(cell: TeamCellProtocol? = nil) {
//        self.cellView = cell
//    }
    
    // MARK: - Public Functions
    
    // MARK: - Configure Controller
    func getData() {
        view?.showIndicator()
        api.getTeamData(met: met, teamId: teamId, APIkey: APIkey) { result in
            
            self.view?.hideIndicator()
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let result = data.result else { return }
                self.teamResult = result
                
                guard let players = result[0].players else { return }
                self.players = players
                
                guard let  coaches = result[0].coaches else { return }
                self.coaches = coaches
                                
                self.view?.reloeadCollectionView()
                
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
    
    
    // MARK: - Private Functiong

}
