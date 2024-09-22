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
}

enum APIEror: Error {
    case failedToGetData
}

class APICaller {
    //Ini adalah cara untuk mengakses instance singleton dari class APICaller. Anda tidak perlu membuat instance baru setiap kali ingin memanggil fungsi di class tersebut. Cukup gunakan instance tunggal yang sudah ada, yaitu shared.
    static let shared = APICaller()
    
    // Enum untuk mengelola endpoint
    enum Endpoint: String {
        case trendingMovies = "/3/trending/movie/day?"
        case trendingTVs = "/3/trending/tv/day?"
        case upcomingMovies = "/3/movie/upcoming?language=en-US&page=1"
        case popularMovies = "/3/movie/popular?language=en-US&page=1"
        case topRatedMovies = "/3/movie/top_rated?language=en-US&page=1"
    }

    // Fungsi umum untuk memanggil API
    private func fetchData<T: Decodable>(
        from endpoint: Endpoint,
        completion: @escaping (Result<[T], APIEror>) -> Void
    ) {
        guard let url = URL(string: "\(Constant.baseUrl)\(endpoint.rawValue)&api_key=\(Constant.API_KEY)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results as! [T]))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }

    func getTrendingMovies(completion: @escaping (Result<[Title], APIEror>) -> Void) {
        fetchData(from: .trendingMovies, completion: completion)
    }

    func getTrendingTVs(completion: @escaping (Result<[Title], APIEror>) -> Void) {
        fetchData(from: .trendingTVs, completion: completion)
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], APIEror>) -> Void) {
        fetchData(from: .upcomingMovies, completion: completion)
    }
    
    func getPopular(completion: @escaping (Result<[Title], APIEror>) -> Void) {
        fetchData(from: .popularMovies, completion: completion)
    }

    func getTopRated(completion: @escaping (Result<[Title], APIEror>) -> Void) {
        fetchData(from: .topRatedMovies, completion: completion)
    }
}
