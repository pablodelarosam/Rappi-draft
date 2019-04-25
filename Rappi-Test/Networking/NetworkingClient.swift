//
//  NetworkingClient.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/20/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation


public final class NetworkClient {
  
    // MARK: - Object Lifecycle
     init() {
    
    }

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
    
    func getMovieDetail(idMovie: Int, success: @escaping (Media) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US"
        callAPIMovieDetail(link: url, completion: success)
    }
    
    struct ResultItemsBodyMovieList: Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Media]
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
    //https://api.themoviedb.org/3/movie/{movie_id}?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US
    
    
}
