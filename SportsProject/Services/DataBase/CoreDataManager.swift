//
//  CoreDataManager.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import UIKit
import Foundation
import CoreData

// MARK: - CoreData Protocol
protocol CoreDataManagerProtocol {
   
}

// MARK: - CoreData Manager
final class CoreDataManager {
    
    // MARK: - Variables
    var context: NSManagedObjectContext!
    private var items: [TeamModelDB]  = []
//    var teams : [NSManagedObject]!
//    var players : [NSManagedObject]!
    
    // MARK: - Singletone instance
    static let instance: CoreDataManager = CoreDataManager()
    
    // MARK: - Initializer
    private init() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - insertLeague
    func insertLeague(league: LeagueModelDB) {
        let player = NSEntityDescription.insertNewObject(forEntityName: "PlayerDB", into: context) as! PlayerDB
        let team = NSEntityDescription.insertNewObject(forEntityName: "TeamDB", into: context) as! TeamDB
        
        guard let  leaguePlayers = league.players else { return }
        // player has 7 Attribute
        for item in leaguePlayers {
            player.playerKey = Int32(item.playerKey ?? 0)
            player.playerName = item.playerName
            player.playerType = item.playerType
            player.playerNumber = item.playerNumber
            player.playerRating  = item.playerRating
            player.playerImage = item.playerImage
            //        player.playerImageData = ""
            if item.playerImageData != nil {
                player.playerImageData = item.playerImageData
            }
        }
        
        context.insert(player)
        
        do {
            try context.save()  // save after insert
            print("insert Successfully")
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Fetch All Teams
    func fetchTeams(completionHandler: (Result<[TeamModelDB], Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = TeamDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false // prevent => data: <fault> ERROR
        do {
            let result = try context.fetch(fetchRequest)
            print(result.count)
            for singleTeam in result {
                guard let teamName = singleTeam.teamName, let teamLogo = singleTeam.teamLogo, let teamLogoData = singleTeam.teamLogoData, let coaches = singleTeam.coaches else { break }
                let teamKey = Int(singleTeam.teamKey)
                
                let team = TeamModelDB(teamKey: teamKey, teamName: teamName, teamLogo: teamLogo, teamLogoData: teamLogoData, coaches: coaches)

                items.append(team)
            }
            print("fetch successfully \(result.count) movie")
            completionHandler(.success(items))
        } catch {
            print(error)
            completionHandler(.failure(error))
        }

    }
    
    // MARK: - Fetch Single Team
    func fetchSingleTeam(title: String, completionHandler: (Result<TeamModelDB, Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = TeamDB.fetchRequest()
        let predeicate = NSPredicate(format: "title='\(title)'")

        fetchRequest.predicate = predeicate
        do {
            let result = try context.fetch(fetchRequest)
            guard let singleTeam = result.first else { return }
            guard let teamName = singleTeam.teamName, let teamLogo = singleTeam.teamLogo, let teamLogoData = singleTeam.teamLogoData, let coaches = singleTeam.coaches else { return }
            let teamKey = Int(singleTeam.teamKey)
            
            let team = TeamModelDB(teamKey: teamKey, teamName: teamName, teamLogo: teamLogo, teamLogoData: teamLogoData, coaches: coaches)
            
            print("fetch Single Team successfully")
            completionHandler(.success(team))
        } catch {
            print(error)
            completionHandler(.failure(error))
        }

    }


//    func removeMovie(title: String) {
//        let fetchRequest = Movie.fetchRequest()
//        let predicate = NSPredicate(format: "title='\(title)'")
//        fetchRequest.predicate = predicate
//        do {
//            let result = try AppDelegate.context.fetch(fetchRequest)
//            for singleMovie in result {
//                AppDelegate.context.delete(singleMovie)
//            }
//
//            try AppDelegate.context.save()
//            print("remove row successfully")
//        } catch {
//            print(error)
//        }
//    }

}

