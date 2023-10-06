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
protocol DataBaseManagerProtocol {
//    func insertLeague(_ item: LeagueModelDB, completion: () -> Void)
    func insertLeague(_ item: LeagueModelDB)
    func fetchLeagues(completionHandler: @escaping(Result<[LeagueModelDB], Error>) -> Void)
    func fetchSingleLeague(leagueName: String, completionHandler: (Result<LeagueModelDB, Error>) -> Void)
    func removeLeague(leagueName: String)
}

// MARK: - CoreData Manager
final class CoreDataManager: DataBaseManagerProtocol {
    
    // MARK: - Variables
    var context: NSManagedObjectContext!
    private var items: [LeagueModelDB]  = []
    
    
    // MARK: - Singletone instance
//    static let instance: CoreDataManager = CoreDataManager()
    
    // MARK: - Initializer
    init() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - insertLeague
    func insertLeague(_ item: LeagueModelDB) {
        let league = NSEntityDescription.insertNewObject(forEntityName: "LeagueDB", into: context) as! LeagueDB
        
        league.leagueId = Int32(item.leagueId ?? 0)
        league.pathURL = item.pathURL
        league.leagueName = item.leagueName
        
        // TODO: - Save image, not string
//        if league.leagueLogo != nil {
//            league.leagueLogo = item.leagueLogoData
//        }
        league.leagueLogo = item.leagueLogo
        
        context.insert(league)
        do {
            try context.save()  // save after insert
            print("insert Successfully")
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Fetch All Teams
    func fetchLeagues(completionHandler: @escaping(Result<[LeagueModelDB], Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = LeagueDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false // prevent => data: <fault> ERROR
        do {
            let result = try context.fetch(fetchRequest)
            print(result.count)
            for singleLeague in result {
                guard let pathURL = singleLeague.pathURL, let leagueName = singleLeague.leagueName, let leagueLogo = singleLeague.leagueLogo else { break }
                let leagueId = Int(singleLeague.leagueId)
                
                let league = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo)

                items.append(league)
            }
            print("fetch successfully \(result.count) league")
            completionHandler(.success(items))
        } catch {
            print(error)
            completionHandler(.failure(error))
        }

    }
    
    // MARK: - Fetch Single Team
    func fetchSingleLeague(leagueName: String, completionHandler: (Result<LeagueModelDB, Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = LeagueDB.fetchRequest()
        let predeicate = NSPredicate(format: "leagueName='\(leagueName)'")
        
        fetchRequest.predicate = predeicate
        do {
            let result = try context.fetch(fetchRequest)
            guard let singleLeague = result.first else { return }
            guard let pathURL = singleLeague.pathURL, let leagueName = singleLeague.leagueName, let leagueLogo = singleLeague.leagueLogo else { return }
            let leagueId = Int(singleLeague.leagueId)
            
            let league = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo)
            
            print("Fetch single league successfully")
            completionHandler(.success(league))
        } catch {
            print(error)
            completionHandler(.failure(error))
        }
    }


    func removeLeague(leagueName: String) {
        let fetchRequest = LeagueDB.fetchRequest()
        let predicate = NSPredicate(format: "leagueName='\(leagueName)'")
        fetchRequest.predicate = predicate
        do {
            let result = try context.fetch(fetchRequest)
            for singleLeague in result {
                context.delete(singleLeague)
            }

            try context.save()
            print("remove row successfully")
        } catch {
            print(error)
        }
    }
}

