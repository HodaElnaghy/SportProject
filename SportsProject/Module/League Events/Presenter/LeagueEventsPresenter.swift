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
//    private var reachability: ReachabilityManager?
    private var dbManager: DataBaseManagerProtocol?
   
    private let api: LeagueEventsAPIProtocol = LeagueEventsAPI()
    private var upcomingEvents = Array<LeagueEventData>()
    private var latestResults = Array<LeagueEventData>()
    private var teams = Array<TeamResult>()
    
    
    private var pathURL: String!
    private var leagueId: Int?
//    private var isConnected: Bool!
    
    private var metFixtures: Met = .fixtures
    private var metTeams: Met = .teams
    private var apiKey = Token.APIKey
    
    private var upcomingFrom = DateManager.shared.currentDateInStringFormat()
    private var upcomingTo = DateManager.shared.nextDateInStringFormat(6)
    
    // var latestTo = upcomingFrom // inside it's function
    private var latestFrom = DateManager.shared.previousDaysInStringFormat(-6)
    
    
    private var no = "!!"
 
    // MARK: - Initializer
    init(view: LeagueEventsView? = nil, pathURL: String, leagueId: Int?) {
        self.view = view
        self.pathURL = pathURL
        self.leagueId = leagueId
//        reachability = ReachabilityManager.shared
        dbManager = CoreDataManager()
    }
    
    // MARK: -  Public Functions
    func viewDidLoad() {
//        configConnectivity()
        getUpcomingEvents()
        getlatestResults()
        getAllTeams()
    }
    
//    func configConnectivity() {
//        startNotification()
//        handleReachability()
//    }
//
    // MARK: - Connectivity
//    private func startNotification() {
//        reachability?.startNotification()
//    }
//
//    func stopNotification() {
//        reachability?.stopNotification()
//    }
//
//    private func handleReachability() {
//        reachability?.handleReachability(completion: { [weak self] connection in
//            guard let self = self else { return }
//            switch connection {
//            case .none:
//                print("SIIIIIIIIIIIIIIIII")
//                isConnected = false
//                view?.displayMessage(message: ConnectivityMessage.noInternet, messageError: true)
//            case .unavailable:
//                print("SIIIIIIIIIIIIIIIII")
//                isConnected = false
//                view?.displayMessage(message:  ConnectivityMessage.noInternet, messageError: true)
//            case .wifi:
//                print("SIIIIIIIIIIIIIIIII")
//                isConnected = true
//                if teams.isEmpty { // to make sure it called once
////                    getAllTeams()
////                    getUpcomingEvents()
////                    getlatestResults()
//                }
//                view?.displayMessage(message: ConnectivityMessage.wifiConnect, messageError: false)
//            case .cellular:
//                print("SIIIIIIIIIIIIIIIII")
//                isConnected = true
//                if teams.isEmpty {
////                    getAllTeams()
////                    getUpcomingEvents()
////                    getlatestResults()
//                }
//                view?.displayMessage(message: ConnectivityMessage.cellularConnect, messageError: false)
//            }
//        })
//    }
//
//    func isConnectedToInternet() -> Bool {
//        return isConnected
//    }
    
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
        let latestTo = upcomingFrom
        
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
        return upcomingEvents.count
    }
    
    func getLatestResultsCount() -> Int {
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
    
    // MARK: - View Protocol, Navigation
    
    func didSelectRow(index: Int) {
        let team = teams[index]
        print(team.teamKey)
        print(pathURL)
        view?.navigateToTeamScreen(pathURL: pathURL, teamId: team.teamKey)
    }
    
    func showAlert() {
        view?.showAlert()
    }
    
    // MARK: - Private Functions
    
    func getLeagueDetails() -> (leagueName: String?, leagueLogo: String?) {
        let event = upcomingEvents.first
        return(event?.leagueName, event?.leagueLogo)
    }
    
    func insertleague(_ item: LeagueModelDB) {
        dbManager?.insertLeague(item)
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
