//
//  MediaDetailViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/21/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {

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
        }
    }
    
    private func getMovieDetails() {
        guard let idMovie = media?.id else { fatalError() }
        
        NetworkClient.sharedInstace.getMovieDetail(idMovie: idMovie) { (movie) in
            DispatchQueue.main.async {
                self.originalTitleLabelValue.text = movie.title
                if let image = movie.poster_path {
                    let urlImage = "https://image.tmdb.org/t/p/w500/\(image)"
                    self.imageMedia.loadImageUsingUrlString(urlString: urlImage)
                }
                
                if let overviewMedia =  movie.overview {
                    self.overviewLabelValue.text = overviewMedia
                }
                if let releaseDate = movie.release_date {
                    self.releaseDateLabelValue.text = releaseDate
                    
                }
                
                if let genre = movie.genres?[0].name {
                    self.genreLabelValue.text = genre
                }
                
                if let duration =  movie.runtime {
                    self.durationLabelValue.text = "\(duration) min"
                }
                
            }
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
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text  = "Género"
        return label
    }()
    
    let genreLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duration"
        label.numberOfLines = 0
        return label
    }()
    
    let durationLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
    
    private lazy var gebreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel, genreLabelValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
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
    
    private lazy var durationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [durationLabel, durationLabelValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
        
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
        let stackView = UIStackView(arrangedSubviews: [dateStackView, gebreStackView, durationStackView,  titleStackView, overviewStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getMovieDetails()
        // here's our entry point into our app
        view.addSubview(imageMedia)
        view.addSubview(masterStackView)
        
        setupLayout()
   
    }
    

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
