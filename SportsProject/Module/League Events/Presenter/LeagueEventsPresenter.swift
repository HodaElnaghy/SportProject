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
    private let dbManager: DataBaseManagerProtocol?
    private let api: LeagueEventsAPIProtocol = LeagueEventsAPI()

    // For (football, basketball, and cricket)
    private var upcomingEvents = Array<LeagueEventModel>()
    private var latestResults = Array<LeagueEventModel>()
    private var teams = Array<TeamResult>()
    
    // For tennis
    private var tennisUpcomingEvents = [TennisEventModel]()
    private var tennisLatestResults = [TennisEventModel]()
    private var tennisPlayers = [TennisPlayerResult]()
    
////    private let imageData: Data?
    private let model: CustomSportModel?
    private let apiKey = Token.APIKey

    // Dates
    private let upcomingFrom = DateManager.shared.currentDateInStringFormat()
    private let upcomingTo = DateManager.shared.nextDateInStringFormat(14)
    private let latestTo = DateManager.shared.currentDateInStringFormat()
    private let latestFrom = DateManager.shared.previousDaysInStringFormat(-14)
 
    // MARK: - Initializer
    init(view: LeagueEventsView? = nil, model: CustomSportModel?) {
        self.view = view
        self.model = model
        dbManager = CoreDataManager()
    }

    // MARK: -  Public Functions
    func viewDidLoad() {
//        configConnectivity()
        getUpcomingEvents()
        getlatestResults()
        getAllTeams()
        
        getTennisUpcomingEvnents()
        getTennisLatestEvnents()
        getTennisPlayer()
    }

    
    // MARK: - Fetch Data For Compositional Layout Controller (Football, Basketball, and Cricket)
    func getUpcomingEvents() {
        //view?.sectionOneShowIndicator()
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        api.getEvents(met: Met.fixtures.rawValue, leagueId: leagueId, from: upcomingFrom, to: upcomingTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
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
        //view?.sectionTwoShowIndicator()
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        api.getEvents(met: Met.fixtures.rawValue, leagueId: leagueId, from: latestFrom, to: latestTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
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
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        api.getAllTeams(met: Met.teams.rawValue, leagueId: leagueId, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
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
    
    // MARK: - Fetch Data For Compositional Layout Controller (Tennis)
    func getTennisUpcomingEvnents() {
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        api.getTennisEvents(met: Met.fixtures.rawValue, leagueId: leagueId, from: upcomingFrom, to: upcomingTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let events = data.result else { return }
                tennisUpcomingEvents = events
                self.view?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTennisLatestEvnents() {
        let latestTo = upcomingFrom
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        api.getTennisEvents(met: Met.fixtures.rawValue, leagueId: leagueId, from: latestFrom, to: latestTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let events = data.result else { return }
                tennisLatestResults = events
                self.view?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTennisPlayer() {
        guard let leagueId = model?.leagueKey, let pathURL = model?.sport.rawValue else { return }
        // players count: 47 for leagueId = 2646
        api.getTennisPlayers(met: Met.players.rawValue, leagueId: leagueId, APIkey: apiKey, pathURL: pathURL) { [weak self] res in
            guard let self = self else { return }
            
            switch res {
            case .success(let data):
                guard let data = data else { return }
                guard let players = data.result else { return }
                print("players count: \(players.count)")
                tennisPlayers = players
                self.view?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Configure Sections For (football, basketball, and cricket)
    func getUpcomingEventsCount() -> Int {
        if model?.sport == SportType.tennis {
            return tennisUpcomingEvents.count
        } else {
            return upcomingEvents.count
        }
    }
    
    func getLatestResultsCount() -> Int {
        if model?.sport == SportType.tennis {
            return tennisLatestResults.count
        } else {
            return latestResults.count
        }
    }
    
    func getAllTeamsCount() -> Int {
        if model?.sport == SportType.tennis {
            return tennisPlayers.count
        } else {
            return teams.count
        }
    }
    
    func configureUpcomingEvents(cell: LeagueCustomCellProtocol, for index: Int) {
        if model?.sport == SportType.tennis {
            if !tennisUpcomingEvents.isEmpty {  // To avoid (Out of range error), i return at least one cell in cellForRow at:indexPath while array isEmpty. !!!
                let event = tennisUpcomingEvents[index]
                configureCellForTennis(cell: cell, by: event, for: index)
            }
        } else {
            if !upcomingEvents.isEmpty { // To avoid (Out of range error), i return at least one cell in cellForRow at:indexPath while array isEmpty. !!!
                let event = upcomingEvents[index]
                configureCell(cell: cell, by: event, for: index)
            }
        }
    }
    
    func configurLatestResults(cell: LeagueCustomCellProtocol, for index: Int) {
        if model?.sport == SportType.tennis {
            if !tennisLatestResults.isEmpty {
                let event = tennisLatestResults[index]
                configureCellForTennis(cell: cell, by: event, for: index)
            }
        } else {
            if !latestResults.isEmpty {
                let event = latestResults[index]
                configureCell(cell: cell, by: event, for: index)
            }
        }
    }
    
    func configureTeam(cell: TeamCustomCellProtocol, for index: Int) {
        if model?.sport == SportType.tennis {
            if !tennisPlayers.isEmpty {
                let player = tennisPlayers[index]
                cell.displayName(player.playerName ?? "no")
                cell.displayImage(by: player.playerLogo)
            }
        } else {
            if !teams.isEmpty {
                let team = teams[index]
                cell.displayName(team.teamName ?? "no")
                cell.displayImage(by: team.teamLogo)
            }
        }
    }
    
    // MARK: - View Protocol, Navigation
    
    func didSelectRow(index: Int) {
            if model?.sport == SportType.football {
                let team = teams[index]
                view?.navigateToTeamScreen(pathURL:  (model?.sport.rawValue)!, teamId: team.teamKey)
            } else {
                view?.showAlertNotAllowedToNavigate()
               print("Only football allowed to navigate to next screen!!")
            }
        }
    
    func showAlert() {
        view?.showAlert()
    }
    
    // MARK: - Core Data

//    func addLeagueToFavorite() {
//        let flag = checkForLeagueId(leagueId: leagueId!)
//        if flag {
////            view?.downloadImage(from: (selectedLeague?.leagueLogo)!)
//            let leagueModelDB = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: selectedLeague?.leagueName, leagueLogo: selectedLeague?.leagueLogo, leagueLogoImage: imageData)
//            
//            dbManager?.insertLeague(leagueModelDB) // Insert League into favorites
//        } else {
//            print("Can't Find The League!!!")
//        }
//    }
    
//    func getImageData(_ data: Data?) {
//        guard let data = data else { return }
//        imageData = data
//    }
    
    func getLeagueDetails() -> (leagueName: String?, leagueLogo: String?) {
        return (model?.leagueName, model?.leagueLogo)
    }
    
    func insertLeague(_ item: LeagueModelDB) {
        dbManager?.insertLeague(item)
    }
    
    func removeLeague() {
//        dbManager?.removeLeague(leagueId: leagueId!)
        guard let legueId = model?.leagueKey else { return }
        dbManager?.removeLeague(leagueId: legueId)
    }
    
    func isFavorite() -> Bool {
//        return dbManager?.isFavorite(leagueId: leagueId!) ?? false
        guard let legueId = model?.leagueKey else { return false}
        return dbManager?.isFavorite(leagueId: legueId) ?? false
    }
    
    
    // MARK: - Private Functions
    // MARK: Football, Basketball, and Cricket
    private func configureCell(cell: LeagueCustomCellProtocol, by event: LeagueEventModel, for index: Int) {
        cell.displayEventHomeTeamName(event.eventHomeTeam ?? "no")
        cell.displayEventAwayTeamName(event.eventAwayTeam ?? "no")
        
        cell.displayHomeTeamImage(by: event.homeTeamLogo)
        cell.displayAwayTeamImage(by: event.awayTeamLogo)
        cell.displayLeagueImage(by: event.leagueLogo)
        
        cell.displayEventState(event.eventStatus ?? "no")
        cell.displayFinalResult(event.eventFinalResult ?? "no")
        
        cell.diaplayEventTime(event.eventTime ?? "no")
        cell.diaplayEventDate(event.eventDate ?? "no")
    }
    
    // MARK: Tennis
    private func configureCellForTennis(cell: LeagueCustomCellProtocol, by event: TennisEventModel, for index: Int) {
        cell.displayEventHomeTeamName(event.eventFirstPlayer ?? "no")
        cell.displayEventAwayTeamName(event.eventSecondPlayer ?? "no")
        
        cell.displayHomeTeamImage(by: event.eventFirstPlayerLogo)
        cell.displayAwayTeamImage(by: event.eventSecondPlayerLogo)
        cell.displayLeagueImage(by: "")
        
        cell.displayEventState(event.eventStatus ?? "no")
        cell.displayFinalResult(event.eventFinalResult ?? "no")
        
        cell.diaplayEventTime(event.eventTime ?? "no")
        cell.diaplayEventDate(event.eventDate ?? "no")
    }
    
}


// MARK: - Connectivity

//    func configConnectivity() {
//        startNotification()
//        handleReachability(view: view)
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

