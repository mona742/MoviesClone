//
//  Tvs.swift
//  MoviesClone
//
//  Created by mona alshiakh on 25/07/1444 AH.
//

import Foundation

struct TrendingTvsResponse: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double
    let vote_count: Int
    let popularity: Double
    
}
