//
//  Upcoming.swift
//  MoviesClone
//
//  Created by mona alshiakh on 27/07/1444 AH.
//

import Foundation

struct UpcomingMoviesResponse: Codable {
    let results: [Upcoming]
}

struct Upcoming: Codable {
    let poster_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    let vote_average: Double?
    
    
    
}

/*
 {
   "page": 1,
   "results": [
     {
       "poster_path": "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
       "adult": false,
       "overview": "A lighthouse keeper and his wife living off the coast of Western Australia raise a baby they rescue from an adrift rowboat.",
       "release_date": "2016-09-02",
       "genre_ids": [
         18
       ],
       "id": 283552,
       "original_title": "The Light Between Oceans",
       "original_language": "en",
       "title": "The Light Between Oceans",
       "backdrop_path": "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
       "popularity": 4.546151,
       "vote_count": 11,
       "video": false,
       "vote_average": 4.41
     },
 */
