//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 21/09/24.
//

import Foundation

struct Constant {
    static let API_KEY = "d97528c08fc7b74b7e5bdfcc56adbcb4"
    static let baseUrl = "https://api.themoviedb.org"
    static let YoutubeBaseUrl = "https://www.googleapis.com/youtube/v3/"
    static let YoutubeAPI_Key = "AIzaSyBfTAV7BaaQzxyRA5BIGIcYvl3xeK_ZZKw"
}

enum APIEror: Error {
    case failedToGetData
}

class APICaller {
    //Ini adalah cara untuk mengakses instance singleton dari class APICaller. Anda tidak perlu membuat instance baru setiap kali ingin memanggil fungsi di class tersebut. Cukup gunakan instance tunggal yang sudah ada, yaitu shared.
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/movie/day?api_key=\(Constant.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
             
            do {
                //Inisialization and then Decoder
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTVs(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/tv/day?api_key=\(Constant.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/upcoming?api_key=\(Constant.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/popular?api_key=\(Constant.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/top_rated?api_key=\(Constant.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], APIEror>)-> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/3/discover/movie?api_key=\(Constant.API_KEY)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], APIEror>)-> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: "\(Constant.baseUrl)/3/search/movie?query=\(query)&api_key=\(Constant.API_KEY)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self ,from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, APIEror>)-> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "\(Constant.YoutubeBaseUrl)search?q=\(query)&key=\(Constant.YoutubeAPI_Key)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
        
    }
}
