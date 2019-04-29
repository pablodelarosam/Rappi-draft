//
//  SeriesCell.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/26/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData

class SeriesCell: MediaGenericCell {

    

    override func reachabilityMovies() {
        mediaCategories = [MediaCategory]()

        let hasConnection = Reachability()?.connection == .none
        print("Connection ", hasConnection)
        if hasConnection {

            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            NetworkClient.sharedInstace.getAiringTodaySeries(completion: { movies in
                let categories = MediaCategory(name: "Tv airing today", mediaFiles: movies, type: "tv")
                self.mediaCategories?.append(categories)

                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveSeries(series: movies, category: "Tv airing today")
                    dispatchGroup.leave()
                }
            })

            dispatchGroup.enter()
            NetworkClient.sharedInstace.getPopularSeries(completion: { movies in
                let categories = MediaCategory(name: "Popular", mediaFiles: movies, type: "tv")
                self.mediaCategories?.append(categories)

                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveSeries(series: movies, category: "Popular")
                    dispatchGroup.leave()
                }
            })

            dispatchGroup.enter()
            NetworkClient.sharedInstace.getRatedSeries(completion: { movies in
                let categories = MediaCategory(name: "Top rated", mediaFiles: movies, type: "tv")
                self.mediaCategories?.append(categories)
                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveSeries(series: movies, category: "Top rated")
                    dispatchGroup.leave()
                }

            })

            dispatchGroup.notify(queue: .main) { [weak self] in
                self!.collectionView.reloadData()
            }
        } else {

            let db = DatabaseConnector()
            let rawDataMoviesPopular = db.getSeries(category: "Popular")
            let rawDataMoviesUpcoming = db.getSeries(category: "Tv airing today")
            let rawDataMoviesRated = db.getSeries(category: "Top rated")
            let moviesPopular = rawDataMoviesPopular.map({ return Media(raw: $0) })
            let moviesUpcoming = rawDataMoviesUpcoming.map { return Media(raw: $0)}
            let moviesTopRated = rawDataMoviesRated.map { return Media(raw: $0) }
            let categoryPopular = MediaCategory(name: "Popular", mediaFiles: moviesPopular, type: "tv")
            let categoryUpcoming = MediaCategory(name: "Tv airing today", mediaFiles: moviesUpcoming, type: "tv")
            let categoryTopRated = MediaCategory(name: "Top Rated", mediaFiles: moviesTopRated, type: "tv")
            self.mediaCategories? += [categoryUpcoming,  categoryTopRated, categoryPopular]
            self.collectionView.reloadData()
        }
    }
}
