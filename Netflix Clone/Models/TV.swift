//
//  TV.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 22/09/24.
//

import Foundation

struct TrendingTVResponse: Codable {
    let results: [TV]
}

struct TV: Codable, Identifiable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let poster_path: String?
    let original_name: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let vore_average: Double?
}
