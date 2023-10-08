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
    
    // To fetch league details, the current viewController doesn't has the requierd attributes for saving league into coredata.
    private var leagues: [LeaguesModel] = Array<LeaguesModel>()
    private let apiLeagues: LeaguesAPIProtocol = LeaguesAPI()
    private var selectedLeague: LeaguesModel?
    private var imageData: Data?
    
    private let pathURL: String!
    private let leagueId: Int?
//    private var isConnected: Bool!
    
    private let metFixtures: Met = .fixtures
    private let metTeams: Met = .teams
    private let metPlayers: Met = .players
    private let apiKey = Token.APIKey
    
    
    private let upcomingFrom = DateManager.shared.currentDateInStringFormat()
    private let upcomingTo = DateManager.shared.nextDateInStringFormat(8)
    
    // var latestTo = upcomingFrom // inside it's function
    private let latestFrom = DateManager.shared.previousDaysInStringFormat(-8)
    
    private let no = "!!"
 
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
        
        getTennisUpcomingEvnents()
        getTennisLatestEvnents()
        getTennisPlayer()
        
        getLeaguesData() // Retrive league details (image, and name), Helping to save data.
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
    
    // MARK: - Fetch Data For Compositional Layout Controller (Football, Basketball, and Cricket)
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
    
    // MARK: - Fetch Data For Compositional Layout Controller (Tennis)
    func getTennisUpcomingEvnents() {
        guard let leagueId = leagueId else { return }
        api.getTennisEvents(met: metFixtures.rawValue, leagueId: leagueId, from: upcomingFrom, to: upcomingTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
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
        guard let leagueId = leagueId else { return }
        api.getTennisEvents(met: metFixtures.rawValue, leagueId: leagueId, from: latestFrom, to: latestTo, APIkey: apiKey, pathURL: pathURL) { [weak self] result in
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
        guard let leagueId = leagueId else { return }
        // players count: 47 for leagueId = 2646
        api.getTennisPlayers(met: metPlayers.rawValue, leagueId: leagueId, APIkey: apiKey, pathURL: pathURL) { [weak self] res in
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
        if pathURL == URLs.tennis {
            return tennisUpcomingEvents.count
        } else {
            return upcomingEvents.count
        }
    }
    
    func getLatestResultsCount() -> Int {
        if pathURL == URLs.tennis {
            return tennisLatestResults.count
        } else {
            return latestResults.count
        }
    }
    
    func getAllTeamsCount() -> Int {
        if pathURL == URLs.tennis {
            return tennisPlayers.count
        } else {
            return teams.count
        }
    }
    
    func configureUpcomingEvents(cell: LeagueCustomCellProtocol, for index: Int) {
        if pathURL == URLs.tennis {
            if !tennisUpcomingEvents.isEmpty {
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
        if pathURL == URLs.tennis {
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
        if pathURL == URLs.tennis {
            if !tennisPlayers.isEmpty {
                let player = tennisPlayers[index]
                cell.displayName(player.playerName ?? no)
                cell.displayImage(by: player.playerLogo ?? no)
            }
        } else {
            if !teams.isEmpty {
                let team = teams[index]
                cell.displayName(team.teamName ?? no)
                cell.displayImage(by: team.teamLogo ?? no)
            }
        }
        
    }
    
    // MARK: - View Protocol, Navigation
    
    func didSelectRow(index: Int) {
        let team = teams[index]
        print(team.teamKey ?? 99)
        print(pathURL!)
        view?.navigateToTeamScreen(pathURL: pathURL, teamId: team.teamKey)
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
        if checkForLeagueId(leagueId: leagueId!) {
            return (selectedLeague?.leagueName, selectedLeague?.leagueLogo)
        }
        return (nil, nil)
    }
    
    func insertLeague(_ item: LeagueModelDB) {
        dbManager?.insertLeague(item)
    }
    
    func removeLeague() {
        dbManager?.removeLeague(leagueId: leagueId!)
    }
    
    func isFavorite() -> Bool {
        return dbManager?.isFavorite(leagueId: leagueId!) ?? false
    }
    
    
    // MARK: - Private Functions
    private func configureCell(cell: LeagueCustomCellProtocol, by event: LeagueEventModel, for index: Int) {
        cell.displayEventHomeTeamName(event.eventHomeTeam ?? no)
        cell.displayEventAwayTeamName(event.eventAwayTeam ?? no)
        
        cell.displayHomeTeamImage(by: event.homeTeamLogo)
        cell.displayAwayTeamImage(by: event.awayTeamLogo)
        cell.displayLeagueImage(by: event.leagueLogo)
        
        cell.displayEventState(event.eventStatus ?? no)
        cell.displayFinalResult(event.eventFinalResult ?? no)
        
        cell.diaplayEventTime(event.eventTime ?? no)
        cell.diaplayEventDate(event.eventDate ?? no)
    }
    
    private func configureCellForTennis(cell: LeagueCustomCellProtocol, by event: TennisEventModel, for index: Int) {
        cell.displayEventHomeTeamName(event.eventFirstPlayer ?? no)
        cell.displayEventAwayTeamName(event.eventSecondPlayer ?? no)
        
        cell.displayHomeTeamImage(by: event.eventFirstPlayerLogo)
        cell.displayAwayTeamImage(by: event.eventSecondPlayerLogo)
        cell.displayLeagueImage(by: "")
        
        cell.displayEventState(event.eventStatus ?? no)
        cell.displayFinalResult(event.eventFinalResult ?? no)
        
        cell.diaplayEventTime(event.eventTime ?? no)
        cell.diaplayEventDate(event.eventDate ?? no)
    }
}

// MARK: - Calling previous network call to fetch league details
extension LeagueEventsPresenter {
    
    private func getLeaguesData() {
        apiLeagues.getLeaguesData(met: "Leagues", APIKey: apiKey, pathURL: pathURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let leaguesData):
                guard let leaguesData = leaguesData else { return }
                guard let leagues = leaguesData.result else { return }
                
                self.leagues = leagues
                //print(leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func checkForLeagueId(leagueId: Int) -> Bool {
        for league in leagues {
            if league.leagueKey == leagueId {
                selectedLeague = league
                return true
            }
        }
        return false
    }
    
}

