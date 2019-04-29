//
//  MoviesCollectionViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/19/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData
class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout,UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating  {


    private let cellId = "cellId"
    private let seriesCellId = "seriesCellId"
    
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    lazy var menuBar:MenuBar = {
        let mb = MenuBar()
        mb.moviesCollectionViewController = self
        return mb
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        configureMenuBar()
        configureMoviesCollectionView()
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    

    override func viewWillDisappear(_ animated: Bool) {

        if searchController.isActive {
            self.navigationController?.isNavigationBarHidden = false
            searchController.isActive = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.searchController.searchBar.isHidden = false

    }

    
    private func configureMenuBar() {
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
    }
    
     func setUpSearchBar() {
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.barTintColor = .yellow
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if let search = searchString {
            let searchDict: [String: Any] = ["search": search, "active": searchController.isActive]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "search"), object: nil, userInfo: searchDict)
        }
        collectionView.reloadData()
    }

    
    private func configureMoviesCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = .white

        self.collectionView!.register(MediaGenericCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView!.register(SeriesCell.self, forCellWithReuseIdentifier: seriesCellId)
        collectionView.isPagingEnabled = true
        collectionView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = .init(top: 30, left: 0, bottom: 0, right: 0)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
     func scrollMenuToIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        
        collectionView?.scrollToItem(at: indexPath, at: .init(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: seriesCellId, for: indexPath)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as?  MediaGenericCell else { fatalError() }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



