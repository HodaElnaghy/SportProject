//
//  LeagueEventsPresenter.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import Foundation

class LeagueEventsPresenter {
    
    // MARK: - Variables
    private weak var view: LeagueEventsView?
   
    private let api: LeagueEventsAPIProtocol = LeagueEventsAPI()
    private var upcomingEvents = Array<LeagueEventData>()
    private var latestResults = Array<LeagueEventData>()
    private var teams = Array<TeamResult>()
    
    
    private var pathURL: String!
    private var leagueId: Int?
    
    private var metFixtures: Met = .fixtures
    private var metTeams: Met = .teams
    private var apiKey = Token.APIKey
    
    var upcomingFrom = DateManager.shared.currentDateInStringFormat()
    var upcomingTo = DateManager.shared.nextDateInStringFormat(6)
    
    // var latestTo = upcomingFrom // inside it's function
    var latestFrom = DateManager.shared.previousDaysInStringFormat(-6)
    
    
    var no = "!!"
 
    // MARK: - Initializer
    init(view: LeagueEventsView? = nil, pathURL: String, leagueId: Int?) {
        self.view = view
        self.pathURL = pathURL
        self.leagueId = leagueId
    }
    
    // MARK: -  Public Functions
    func viewDidLoad() {
        getUpcomingEvents()
        getlatestResults()
        getAllTeams()
    }
    
    // MARK: - Fetch Data For Compositional Layout Controller
    func getUpcomingEvents() {
        //view?.sectionOneShowIndicator()
        guard let leagueId = leagueId else { return }
        api.getUpcomingEvents(met: metFixtures.rawValue, leagueId: leagueId, from: upcomingFrom, to: upcomingTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
//            self.view?.sectionOneHideIndicator()

            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let upcomingEvents = data.result else { return }
                self.upcomingEvents = upcomingEvents

                //self.view?.reloadSectionOne()
                self.view?.reloadCollectionView()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getlatestResults() {
        var latestTo = upcomingFrom
        
        // TODO: - api.getUpcomingEvents Error call api.upcoming events
        //view?.sectionTwoShowIndicator()
        guard let leagueId = leagueId else { return }
        api.getUpcomingEvents(met: metFixtures.rawValue, leagueId: leagueId, from: latestFrom, to: latestTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            //self.view?.sectionOneHideIndicator()
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let latestResults = data.result else { return }
                self.latestResults = latestResults
                
//                self.view?.reloadSectionTwo()
                self.view?.reloadCollectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllTeams() {
        //view?.sectionThreeShowIndicator()
        guard let leagueId = leagueId else { return }
        api.getAllTeams(met: metTeams.rawValue, leagueId: leagueId, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            //self.view?.sectionThreeHideIndicator()
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let teams = data.result else { return }
                self.teams = teams
                
                //self.view?.reloadSectionThree()
                self.view?.reloadCollectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Configure Sections
    func getUpcomingEventsCount() -> Int {
//        print("Test One: \(upcomingEvents.count)")
        return upcomingEvents.count
    }
    
    func getLatestResultsCount() -> Int {
//        print("Test Two: \(latestResults.count)")
        return latestResults.count
    }
    
    func getAllTeamsCount() -> Int {
        return teams.count
    }
    
    func configureUpcomingEvents(cell: LeagueCustomCellProtocol, for index: Int) {
        let event = upcomingEvents[index]
        configureCell(cell: cell, by: event, for: index)
    }
    
    func configurLatestResults(cell: LeagueCustomCellProtocol, for index: Int) {
        let event = latestResults[index] 
        configureCell(cell: cell, by: event, for: index)
    }

    func configureTeam(cell: TeamCustomCellProtocol, for index: Int) {
        let team = teams[index]
        cell.displayName(team.teamName ?? no)
        cell.displayImage(by: team.teamLogo ?? no)
    }
    
    // MARK: - Navigation
    func didSelectRow(index: Int) {
        let team = teams[index]
        view?.navigateToTeamScreen(pathURL: pathURL, teamId: team.teamKey)
    }
    
    // MARK: - Private Functions
    private func configureCell(cell: LeagueCustomCellProtocol, by event: LeagueEventData, for index: Int) {
        cell.displayEventHomeTeamName(event.eventHomeTeam ?? no)
        cell.displayEventAwayTeamName(event.eventAwayTeam ?? no)
        
        cell.displayHomeTeamImage(by: event.homeTeamLogo ?? no)
        cell.displayAwayTeamImage(by: event.awayTeamLogo ?? no)

        cell.displayEventState(event.eventStatus ?? no)
        cell.displayFinalResult(event.eventFinalResult ?? no)
        
        cell.diaplayEventTime(event.eventTime ?? no)
        cell.diaplayEventDate(event.eventDate ?? no)
    }
}
