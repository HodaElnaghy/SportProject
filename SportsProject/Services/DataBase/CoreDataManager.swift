//
//  CoreDataManager.swift
//  SportsProject
//
//  Created by Mohammed Adel on 30/09/2023.
//

import UIKit
import CoreData


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
        league.leagueLogo = item.leagueLogo // Save String
        
        
        //league.leagueLogoImage = item.leagueLogoImage // Save image
        // TODO: - Save image, not string
        if league.leagueLogoImage != nil {
            league.leagueLogoImage = item.leagueLogoImage
        }
       
        
        context.insert(league)
        do {
            try context.save()  // save after insert
            print("insert Successfully")
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Fetch All Leagues
    func fetchLeagues(completion: @escaping(Result<[LeagueModelDB], Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = LeagueDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false // prevent => data: <fault> ERROR
        do {
            let result = try context.fetch(fetchRequest)
            items = [] // Remove before append on items
            
            for singleLeague in result {
                let pathURL = singleLeague.pathURL
                let leagueName = singleLeague.leagueName
                let leagueLogo = singleLeague.leagueLogo
                let leagueLogoImage = singleLeague.leagueLogoImage
                let leagueId = Int(singleLeague.leagueId)
                
                let league = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo, leagueLogoImage: leagueLogoImage)

                items.append(league)
            }
            print("fetch successfully \(items.count) league")
            completion(.success(items))
        } catch {
            print(error)
            completion(.failure(error))
        }

    }
    
    // MARK: - Fetch Single League
    func fetchSingleLeague(leagueName: String, completion: (Result<LeagueModelDB, Error>) -> Void) {
        //let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let fetchRequest = LeagueDB.fetchRequest()
        let predicate = NSPredicate(format: "leagueName='\(leagueName)'")
        
        fetchRequest.predicate = predicate
        do {
            let result = try context.fetch(fetchRequest)
            guard let singleLeague = result.first else { return }
            let pathURL = singleLeague.pathURL
            let leagueName = singleLeague.leagueName
            let leagueLogo = singleLeague.leagueLogo
            let leagueLogoImage = singleLeague.leagueLogoImage
            let leagueId = Int(singleLeague.leagueId)
            
            let league = LeagueModelDB(leagueId: leagueId, pathURL: pathURL, leagueName: leagueName, leagueLogo: leagueLogo, leagueLogoImage: leagueLogoImage)
            
            print("Fetch single league successfully")
            completion(.success(league))
        } catch {
            print(error)
            completion(.failure(error))
        }
    }

    // MARK: - Is Favorite
    func isFavorite(leagueId: Int) -> Bool {
        let fetchRequest = LeagueDB.fetchRequest()
        let predicate = NSPredicate(format: "leagueId='\(leagueId)'")
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            print("league is favorite =  \(!result.isEmpty)")
            return !result.isEmpty // if isEmpty will return false, means not Favorite
        }
        catch {
            print(error.localizedDescription)
        }
        return false
    }

    // MARK: - Remove League
    func removeLeague(leagueId: Int) {
        let fetchRequest = LeagueDB.fetchRequest()
        let predicate = NSPredicate(format: "leagueId='\(leagueId)'")
        fetchRequest.predicate = predicate
        do {
            let result = try context.fetch(fetchRequest)
            for singleLeague in result {
                context.delete(singleLeague)
            }

            try context.save()
            print("remove row successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Remove ALL Leagues
    func removeALLLeagues() {
        let fetchRequest = LeagueDB.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            for singleLeague in result {
                context.delete(singleLeague)  // row by row
            }

            try context.save()
            print("remove all successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

