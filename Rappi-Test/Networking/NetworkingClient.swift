//
//  NetworkingClient.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/20/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation


public final class NetworkClient {
  
    static var sharedInstace = NetworkClient()
    
    
    //MARK: Movies functions
    func getUpcomingMovies(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPIMovieList(link: url, completion: success)
    }
    
    func getPopularMovies(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPIMovieList(link: url, completion: success)
    }
    
    func getRatedMovies(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPIMovieList(link: url, completion: success)
    }
    
    func getMediaDetail(idMovie: Int, typeMedia: String, success: @escaping (Media) -> Void) {
        let url = "https://api.themoviedb.org/3/\(typeMedia)/\(idMovie)?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US"
 
            print(url)
        
        callAPIMovieDetail(link: url, completion: success)
     
    }
    
    //MARK: Series functions
    
    func getPopularSeries(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/popular?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPISerieList(link: url, completion: success)
    }
    
    func getRatedSeries(completion success: @escaping ([Media]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/tv/top_rated?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPISerieList(link: url, completion: success)
    }
    
    func getAiringTodaySeries(completion success: @escaping ([Media]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/tv/airing_today?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPISerieList(link: url, completion: success)
    }
    
    func getMediaVideos(idMedia: Int, typeMedia: String, completion success: @escaping ([Video]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/\(typeMedia)/\(idMedia)/videos?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US"
        callVideoMedia(link: url, completion: success)
    }
    

    
    
    struct ResultItemsBodyMovieList: Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Media]
    }
    
    func callAPISerieList(link: String, completion: @escaping ([Media]) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                    let data = data
           
                let movies = try JSONDecoder().decode(ResultItemsBodyMovieList.self, from: data!).results
                
                DispatchQueue.main.async {
                    completion(movies)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
    func callAPIMovieList(link: String, completion: @escaping ([Media]) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode.isSuccessHTTPCode,
                    let data = data
                    else {
                        return
                }
                let movies = try JSONDecoder().decode(ResultItemsBodyMovieList.self, from: data).results
                print()
                if let name = movies[0].name {
                    print(name)
                }
                DispatchQueue.main.async {
                    completion(movies)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
    
    
    func callAPIMovieDetail(link: String, completion: @escaping (Media) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode.isSuccessHTTPCode,
                    let data = data
                    else {
                        return
                }
                let movies = try JSONDecoder().decode(Media.self, from: data)
                DispatchQueue.main.async {
                    completion(movies)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func callVideoMedia(link: String, completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode.isSuccessHTTPCode,
                    let data = data
                    else {
                        return
                }
                let videos = try JSONDecoder().decode(VideoBodyList.self, from: data).results
                print()
                if let name = videos[0].name {
                    print(name)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
    
    struct VideoBodyList: Decodable {
        var id: Int?
        var results: [Video]
    }
}
