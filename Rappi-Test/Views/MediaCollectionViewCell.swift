//
//  MediaCollectionViewCell.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/19/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var moviesCollectionViewController = MoviesCollectionViewController()
    var generic = MediaGenericCell()
    var mediaCategory: MediaCategory? {
        didSet {
            if let name = mediaCategory?.name {
                categoryLabel.text = name
            }
        }
    }

    private let categoriesCellId = "categoriesId"
    private var movies: [Media] = [Media]()
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false 
        return view
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.numberOfLines =  2
       label.font = UIFont.boldSystemFont(ofSize: 25)
       label.textColor = .black
       return label
    }()
    
    override func setupViews() {
        super.setupViews()
      //  loadPopularMovies()
        addSubview(categoriesCollectionView)
        addSubview(dividerLineView)
        addSubview(categoryLabel)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoriesCellId)
        addConstraintsWithFormat("H:|-14-[v0]|", views: categoryLabel)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("H:|[v0]|", views: categoriesCollectionView)
        addConstraintsWithFormat("V:|[v2(30)][v0][v1(0.5)]|", views: categoriesCollectionView, dividerLineView, categoryLabel)

    }

    
    //MARK: Categories CollectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = mediaCategory?.mediaFiles?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCellId, for: indexPath) as? CategoryCell else { fatalError() }
            cell.movie = mediaCategory?.mediaFiles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let media = mediaCategory?.mediaFiles?[indexPath.item] {
                generic.showMovieDetails(for: media)
        }
    
    }
}

class CategoryCell: BaseCell {
    
    var movie: Media?  {
        didSet {
           titleLabel.text = movie?.title
            if let image = movie?.poster_path {
                let urlImage = "https://image.tmdb.org/t/p/w500/\(image)"
                mediaImageView.loadImageUsingUrlString(urlString: urlImage)
            }
        }
    }
    
    let mediaImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let alphaLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        addSubview(mediaImageView)
        addSubview(alphaLayer)
        addSubview(titleLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mediaImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mediaImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": alphaLayer]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": alphaLayer]))
        
        titleLabel.topAnchor.constraint(equalTo: mediaImageView.topAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mediaImageView.rightAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mediaImageView.leftAnchor, constant: 0).isActive = true
    }
    
}


