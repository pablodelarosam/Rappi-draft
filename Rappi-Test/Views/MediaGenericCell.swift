//
//  MediaGenericCell.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/24/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData

class MediaGenericCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
     let cellId = "cellId"
    private let networkClient = NetworkClient()
    // let reuseIdentifier = "movieCell"
    lazy var moviesController: MoviesCollectionViewController? = MoviesCollectionViewController()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
     var mediaCategories: [MediaCategory]?
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        reachabilityMovies()
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func showMovieDetails(for media: Media) {
        let detailController = MediaDetailViewController()
        detailController.media = media
    UIApplication.topViewController()?.navigationController!.pushViewController(detailController, animated: true)
    }
    
    //MARK: Check reachability and populate categories
    private func reachabilityMovies() {
        mediaCategories = [MediaCategory]()
        // okay, can you do the rest? yes!
        // you dont implement search function yet, when you finsih that, I can help you next
        // when you do search, do 2 things
        // - search from api, check the api document to call search api (same to what you did to get movies)
        // - search from db, let me write another function, you can call it
        
        let hasConnection = Reachability()?.connection == .none
        print(hasConnection)
        if hasConnection {
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            networkClient.getUpcomingMovies(completion: { movies in
                let categories = MediaCategory(name: "Upcoming", mediaFiles: movies, type: "Upcoming")
                self.mediaCategories?.append(categories)
                
                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveMovies(movies: movies, category: "Upcoming")
                    dispatchGroup.leave()
                }
            })
            
            dispatchGroup.enter()
            networkClient.getPopularMovies(completion: { movies in
                let categories = MediaCategory(name: "Popular", mediaFiles: movies, type: "Popular")
                self.mediaCategories?.append(categories)
                
                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveMovies(movies: movies, category: "Popular")
                    dispatchGroup.leave()
                }
            })
            
            dispatchGroup.enter()
            networkClient.getRatedMovies(completion: { movies in
                let categories = MediaCategory(name: "Top rated", mediaFiles: movies, type: "Top rated")
                self.mediaCategories?.append(categories)
                DispatchQueue.main.async {
                    let db = DatabaseConnector()
                    db.saveMovies(movies: movies, category: "Top rated")
                    dispatchGroup.leave()
                }
                
            })
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                self!.collectionView.reloadData()
            }
        } else {
            
            let db = DatabaseConnector()
            let rawDataMoviesPopular = db.getMovies(category: "Popular")
            let rawDataMoviesUpcoming = db.getMovies(category: "Upcoming")
            let rawDataMoviesRated = db.getMovies(category: "Top rated")
            // the function map, filter, we call high other function
            // map is equal to the fucntion belo
            // pls start the session
            
            /*
             var movies1 = [Media]()
             for data in rawData {
             let movie = Media(raw: data)
             movies1.append(movie)
             }
             */
            // now we runa nd you see popluar only,
            
            let moviesPopular = rawDataMoviesPopular.map({ return Media(raw: $0) })
            let moviesUpcoming = rawDataMoviesUpcoming.map { return Media(raw: $0)}
            let moviesTopRated = rawDataMoviesRated.map { return Media(raw: $0) }
            let categoryPopular = MediaCategory(name: "Popular", mediaFiles: moviesPopular, type: "Popular")
            let categoryUpcoming = MediaCategory(name: "Upcoming", mediaFiles: moviesUpcoming, type: "Upcoming")
            let categoryTopRated = MediaCategory(name: "Top Rated", mediaFiles: moviesTopRated, type: "Top Rated")
            self.mediaCategories? += [categoryUpcoming,  categoryTopRated, categoryPopular]
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return mediaCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MediaCollectionViewCell else {fatalError() }
        cell.mediaCategory = mediaCategories?[indexPath.item]
        cell.generic = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return .init(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
