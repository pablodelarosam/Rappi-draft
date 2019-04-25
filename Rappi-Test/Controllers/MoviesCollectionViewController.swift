//
//  MoviesCollectionViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/19/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData
class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    private let cellId = "cellId"
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
        configureMoviesCollectionView()
        configureMenuBar()
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
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        self.collectionView!.register(MediaGenericCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MediaGenericCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



