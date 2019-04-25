//
//  MediaDetailViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/21/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {
// please paste the category to here alos
    // what screen? the problem is in mediagenericcell
    var category: String?
    var media: Media? {
        didSet {
            navigationItem.title = media?.title
            originalTitleLabelValue.text = media?.title
            if let image = media?.poster_path {
                let urlImage = "https://image.tmdb.org/t/p/w500/\(image)"
                imageMedia.loadImageUsingUrlString(urlString: urlImage)
            }
            
            if let releaseDate = media?.release_date {
                releaseDateLabelValue.text = releaseDate
            }
            if let overviewMedia =  media?.overview {
                overviewLabelValue.text = overviewMedia
            }
            
        //    titleLabel.text = media?.title
        }
    }
    let imageMedia: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black 
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
      //  imageView.backgroundColor = .red
        return imageView
    }()
    
    let imageContainerView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.backgroundColor = .yellow
       return view
    }()
    

    let releaseDateLabel: UILabel = {
       let label = UILabel()
       label.text = "Release date"
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let releaseDateLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [overviewLabel, overviewLabelValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    
    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Original title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let originalTitleLabelValue: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [originalTitleLabel, originalTitleLabelValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateLabel, releaseDateLabelValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var masterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateStackView, titleStackView, overviewStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // here's our entry point into our app
        view.addSubview(imageMedia)
        view.addSubview(masterStackView)
        
        setupLayout()
     
        // oops, maybe this is no need, becuase theapi return whole data for a movie.
        // I leave it here, if you call other api, like get rating, or something, you can save to db
        //let db = DatabaseConnector()
        // need guard let here to make sure the data is not empty  -> safe -> not crash the app
        //guard let movie = media, let category = category else { return }
        //db.saveMovie(movie: movie, category: category)
    }
    
    // you dont have function to get detail here. if you have one, after you get detail, you call databaseConnector to save
    // now, I will call save in viewdidLoad
    
    
    private func setupLayout() {
       // imageMedia.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        imageMedia.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageMedia.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
         imageMedia.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageMedia.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        imageMedia.heightAnchor.constraint(equalToConstant: 300).isActive = true

        masterStackView.topAnchor.constraint(equalTo: imageMedia.bottomAnchor, constant: 20).isActive = true
        masterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        masterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
   
        
        

    }


}
