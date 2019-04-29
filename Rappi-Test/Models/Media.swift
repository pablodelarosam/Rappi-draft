//
//  Media.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/20/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

class Media:  Codable {
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var id: Int?
    var genre_ids: [Int]?
    var title: String?
    var original_title: String?
    var release_date: String?
    var genres: [Genre]?
    var genre: String?
    var runtime: Int?
    var number_of_episodes : Int?
    var number_of_seasons: Int?
    var name: String?
    var first_air_date: String?
    var episode_run_time: [Int]?
    var eposide_run_time_single: Int?
 
    
    init(raw: AnyObject) {
        print(raw)
        poster_path = raw.value(forKey: "poster_path") as? String
        id = raw.value(forKey: "id") as? Int
        title = raw.value(forKey: "title") as? String
        overview = raw.value(forKey: "overview") as? String
        release_date = raw.value(forKey: "release_date") as? String
        genres = raw.value(forKey: "genre") as? [Genre]
        name = raw.value(forKey: "name") as? String
        first_air_date = raw.value(forKey: "first_air_date") as? String
        runtime = raw.value(forKey: "runtime") as? Int
        episode_run_time = raw.value(forKey: "episode_run_time") as? [Int]
        genre = raw.value(forKey: "genreSingle") as? String
        eposide_run_time_single = raw.value(forKey: "eposide_run_time_single") as? Int
    }
    
    init() {
        
    }

    
//    newSerie.setValue(serie.name, forKey: "name")
//    newSerie.setValue(serie.poster_path, forKey: "poster_path")
//    newSerie.setValue(category, forKey: "category")
//    newSerie.setValue(serie.overview, forKey: "overview")
//    newSerie.setValue(serie.first_air_date, forKey: "first_air_date")
//    newSerie.setValue(serie.episode_run_time, forKey: "episode_run_time")
}
