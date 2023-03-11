//
//  APIConnector.swift
//  MoviesClone
//
//  Created by mona alshiakh on 23/07/1444 AH.
//

import Foundation

enum APIError: Error {
    case failedToGetData
}

class APIConnector: API {
    
    static let shared = APIConnector()
    
    func getTrendingMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/trending/movie/day?api_key=\(APIConnector.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                //JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func getTrendingTvs (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/trending/tv/day?api_key=\(APIConnector.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func getUpcomingMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/movie/upcoming?api_key=\(APIConnector.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func getPopular (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/movie/popular?api_key=\(APIConnector.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func getTopRated (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/movie/top_rated?api_key=\(APIConnector.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }

    func getDiscoverMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/discover/movie?api_key=\(APIConnector.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(APIConnector.mainLink)/3/search/movie?api_key=\(APIConnector.apiKey)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(APIConnector.YoutubeMainLink)q=\(query)&key=\(APIConnector.YoutubeApiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion (.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
                
        }
        task.resume()
    }
    
}


