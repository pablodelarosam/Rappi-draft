//
//  DatabaseConnector.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/23/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData

class DatabaseConnector {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveMovies(movies: [Media], category: String) {
       // saveMovie(movie: movies[0], category: category)
        for movie in movies {
            saveMovie(movie: movie, category: category)
        }
    }
    
    func saveMovie(movie: Media, category: String) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else { return }
        let newMovie = NSManagedObject(entity: entity, insertInto: context)
        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.poster_path, forKey: "poster_path")
        newMovie.setValue(category, forKey: "category")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.release_date, forKey: "release_date")
        // if you want to add more field into database, you have to folow this
        // I will add description onlhy, you do dthe rest
        // descirption is a keyword -> can't use
        
        
        do {
            try context.save()
        } catch {
            print("Fail to save")
        }
    }
    
    
    // same to this, here we filter by category -> now we filter by other condition
    
    func searchMovies(keyword: String) -> [AnyObject] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", keyword)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result {
                print(data)
            }
            return result as [AnyObject]
            
        } catch {
            print("Failed")
            return []
        }
    }
    
    func getMovies(category: String) -> [AnyObject] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "category = %@", category)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result as [AnyObject]
            
        } catch {
            print("Failed")
            return []
        }
    }
}



// it saves the movies, let me pull it up

