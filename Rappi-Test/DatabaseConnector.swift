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
        newMovie.setValue(movie.genres?[0].name, forKey: "genreSingle")
        newMovie.setValue(movie.runtime, forKey: "runtime")
        do {
            try context.save()
        } catch {
            print("Fail to save")
        }
    }
    
    func saveMedia(media: Media, category: String) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "MediaCO", in: context) else { return }
        let newMedia = NSManagedObject(entity: entity, insertInto: context)
        newMedia.setValue(media.id, forKey: "id")
        newMedia.setValue(media.title, forKey: "title")
        newMedia.setValue(media.poster_path, forKey: "poster_path")
        newMedia.setValue(category, forKey: "category")
        newMedia.setValue(media.overview, forKey: "overview")
        newMedia.setValue(media.release_date, forKey: "release_date")
        newMedia.setValue(media.genres?[0].name, forKey: "genreSingle")
        newMedia.setValue(media.runtime, forKey: "runtime")
        newMedia.setValue(media.first_air_date, forKey: "first_air_date")
        newMedia.setValue(media.name, forKey: "name")
        newMedia.setValue(media.episode_run_time?[0], forKey: "eposide_run_time_single")
        do {
            try context.save()
        } catch {
            print("Fail to save")
        }
    }
    
    func saveSeries(series: [Media], category: String) {
        for serie in series {
            saveSerie(serie: serie, category: category)
        }
    }
    
    func saveSerie(serie: Media, category: String) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Serie", in: context) else { return }
        let newSerie = NSManagedObject(entity: entity, insertInto: context)
        newSerie.setValue(serie.id, forKey: "id")
        newSerie.setValue(serie.name, forKey: "name")
        newSerie.setValue(serie.poster_path, forKey: "poster_path")
        newSerie.setValue(category, forKey: "category")
        newSerie.setValue(serie.overview, forKey: "overview")
        newSerie.setValue(serie.first_air_date, forKey: "first_air_date")
        newSerie.setValue(serie.episode_run_time, forKey: "episode_run_time")
        //newSerie.setValue(serie.genres, forKey: "genre")
        do {
            try context.save()
        } catch {
            print("Fail to save")
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
    
    func getSeries(category: String) -> [AnyObject] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Serie")
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
    
    func getMedia(id: Int) -> AnyObject {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaCO")
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        do {
            
            let result = try context.fetch(request)
            let singleresult = result.first
            print(result)
            return singleresult as AnyObject
            
        } catch {
            print("Failed")
            return Serie()
        }
    }
    
    func getMovie(id: Int) -> AnyObject {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        do {
           
            let result = try context.fetch(request)
            let singleresult = result.first
            print(result)
            return singleresult as AnyObject
            
        } catch {
            print("Failed")
            return Movie()
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
    
}


