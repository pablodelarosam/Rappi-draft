//
//  MoviesCollectionViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/19/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var mediaCategories: [MediaCategory]?
    private let networkClient = NetworkClient() // where do you learnthis way?
    // it's complicated and useless for beginner.
    // I dont know the best way :(
    // haha you cant know until you work in 5 6 projects. I can show you later.
    // focus onthis first
    private let reuseIdentifier = "movieCell"
    private let menuBar:MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMoviesCollectionView()
        configureMenuBar()
        mediaCategories = [MediaCategory]()

// okay, can you do the rest? yes!
// you dont implement search function yet, when you finsih that, I can help you next
        // when you do search, do 2 things
        // - search from api, check the api document to call search api (same to what you did to get movies)
        // - search from db, let me write another function, you can call it 
        
        let hasConnection = Reachability()?.connection == .none
        if hasConnection {
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            networkClient.getUpcomingMovies(completion: { movies in
                let categories = MediaCategory(name: "Upcoming", mediaFiles: movies, type: "Upcoming")
                self.mediaCategories?.append(categories)
                dispatchGroup.leave()
            })
            
            dispatchGroup.enter()
            networkClient.getPopularMovies(completion: { movies in
                let categories = MediaCategory(name: "Popular", mediaFiles: movies, type: "Popular")
                self.mediaCategories?.append(categories)
                
                let db = DatabaseConnector()
                db.saveMovies(movies: movies, category: "Popular")
                dispatchGroup.leave()
            })
            
            dispatchGroup.enter()
            networkClient.getRatedMovies(completion: { movies in
                let categories = MediaCategory(name: "Top rated", mediaFiles: movies, type: "Top rated")
                self.mediaCategories?.append(categories)
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.collectionView.reloadData()
            }
        } else {
            let db = DatabaseConnector()
            let rawData = db.getMovies(category: "Popular")
            // the function map, filter, we call high other function
            // map is equal to the fucntion belo
            
            /*
 var movies1 = [Media]()
            for data in rawData {
                let movie = Media(raw: data)
                movies1.append(movie)
            }
 */
            // now we runa nd you see popluar only, 
            
            let movies = rawData.map({ return Media(raw: $0) })
            let categories = MediaCategory(name: "Popular", mediaFiles: movies, type: "Popular")
            self.mediaCategories?.append(categories)
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func configureMenuBar() {
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
    }
    
    private func configureMoviesCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.collectionView!.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private struct SegueIdentifiers {
        static let movieIdentifier = "movieSegue"
    }
    
    func showMovieDetails(for media: Media) {
        let detailController = MediaDetailViewController()
        detailController.media = media
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = mediaCategories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MediaCollectionViewCell else {fatalError() }
        cell.mediaCategory = mediaCategories?[indexPath.item]
        cell.moviesCollectionViewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
}

