//
//  DataPersistenceManager.swift
//  MoviesClone
//
//  Created by mona alshiakh on 07/03/2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.overview = model.overview
        item.title = model.title
        item.poster_path = model.poster_path
        item.id = Int64(model.id!)
        item.adult = Bool(model.adult!)
        item.backdrop_path = model.backdrop_path
        //item.genre_ids = model.genre_ids as NSObject? as! Int64
        item.original_language = model.original_language
        item.popularity = Double(model.popularity!)
        item.release_date = model.release_date
        item.video = model.video!
        item.vote_count = Int64(model.vote_count!)
        item.vote_average = model.vote_average!
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
        
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping(Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        let requset: NSFetchRequest<TitleItem>
        requset = TitleItem.fetchRequest()
        do {
            let titles = try context.fetch(requset)
            completion(.success(titles))
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appDelegate.persistentContainer.viewContext
        // asking the database manager to delete a certain object
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
