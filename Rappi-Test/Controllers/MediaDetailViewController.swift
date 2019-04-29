//
//  MediaDetailViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/21/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit
import CoreData

class MediaDetailViewController: UIViewController {

    var typeMedia: String?
    var category: String? 
    var media: Media? {
        didSet {
            navigationItem.title = media?.title ?? media?.name 
            originalTitleLabelValue.text = media?.title ?? media?.name
        }
    }
    
     func getMediaDetails() {
        guard let idMovie = media?.id else { fatalError() }
        guard let type = typeMedia else { fatalError() }
        let hasConnection = Reachability()?.connection != .none
        if hasConnection {
            NetworkClient.sharedInstace.getMediaDetail(idMovie: idMovie, typeMedia: type) { (media) in
                DispatchQueue.main.async {
                    self.originalTitleLabelValue.text = media.title ?? media.name
                    if let image = media.poster_path {
                        let urlImage = "https://image.tmdb.org/t/p/w500/\(image)"
                        self.imageMedia.loadImageUsingUrlString(urlString: urlImage)
                    }
                    
                    if let overviewMedia =  media.overview {
                        self.overviewLabelValue.text = overviewMedia
                    }
                    if let releaseDate = media.release_date ?? media.first_air_date  {
                        self.releaseDateLabelValue.text = releaseDate
                        
                    }
                    print("GENEROS",  media.genres![0])
                    if media.genres!.count > 0 {
                        if let genre =  media.genres?[0].name   {
                            self.genreLabelValue.text = genre
                        }
                    }
                    if let duration =  media.runtime ?? media.episode_run_time?[0]  {
                        self.durationLabelValue.text = "\(duration) min"
                    }
                    if let category = self.category {
                        let db = DatabaseConnector()
                        print("Current category \(category)")
                        if self.typeMedia == "movie" {
                            db.saveMedia(media: media, category: category)

                        } else if self.typeMedia == "tv" {
                            db.saveMedia(media: media, category: category)
                        }
                    
                    }
                }
            }
        } else {
            let db = DatabaseConnector()
            let rawDataMedia: AnyObject!
            if typeMedia == "movie" {
                rawDataMedia = db.getMedia(id: (media?.id!)!)
            } else {
                rawDataMedia = db.getMedia(id: (media?.id!)!)
            }

            DispatchQueue.main.async {
                
                let mediaToShow =  Media(raw: rawDataMedia)
                print("media to show", mediaToShow)
                if let image = mediaToShow.poster_path {
                    let urlImage = "https://image.tmdb.org/t/p/w500/\(image)"
                    self.imageMedia.loadImageUsingUrlString(urlString: urlImage)
                }
                
                if let overviewMedia =  mediaToShow.overview {
                    self.overviewLabelValue.text = overviewMedia
                }
                if let releaseDate = mediaToShow.release_date ?? mediaToShow.first_air_date  {
                    self.releaseDateLabelValue.text = releaseDate
                    
                }

                    if let genre =  mediaToShow.genre   {
                        self.genreLabelValue.text = genre
                    }
                
                
                
                if let duration =  mediaToShow.runtime ?? mediaToShow.eposide_run_time_single  {
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
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
    
    let buttonTrailer: UIButton = {
        let button = UIButton()
        button.setTitle("Trailer", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 8, green: 27, blue: 35)
        button.tintColor = .black
        button.setTitleColor( .white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(changeController), for: .touchUpInside)
        return button
    }()
    
    @objc func changeController() {
        print("tap")
        let trailer =  TrailerViewController()
        trailer.idMedia = media?.id
        trailer.typeMedia = typeMedia!
        navigationController?.pushViewController(trailer, animated: true)
    }
    
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
        let stackView = UIStackView(arrangedSubviews: [dateStackView, gebreStackView, durationStackView,  titleStackView, overviewStackView, buttonTrailer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollViewContainer: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageMedia, masterStackView])
        
        view.axis = .vertical
        view.spacing = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getMediaDetails()
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        setupLayout()
   
    }
    

    private func setupLayout() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageMedia.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageMedia.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        masterStackView.topAnchor.constraint(equalTo: imageMedia.bottomAnchor, constant: 20).isActive = true
        masterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        masterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        
        
    }


}
