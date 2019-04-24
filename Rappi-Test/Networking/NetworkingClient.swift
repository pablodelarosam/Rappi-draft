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
        callAPI(link: url, completion: success)
    }
    
    func getPopularMovies(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPI(link: url, completion: success)
    }
    
    func getRatedMovies(completion success: @escaping ([Media]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=118ddbbc27927d72b004a53a35011aaf&language=en-US&page=1"
        callAPI(link: url, completion: success)
    }
    
    struct ResultItemsBody: Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Media]
    }
    func callAPI(link: String, completion: @escaping ([Media]) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode.isSuccessHTTPCode,
                    let data = data
                    else {
                        return
                }
                let movies = try JSONDecoder().decode(ResultItemsBody.self, from: data).results
                completion(movies)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    
}
