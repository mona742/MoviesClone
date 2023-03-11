//
//  YoutubeSearchResponse.swift
//  MoviesClone
//
//  Created by mona alshiakh on 07/08/1444 AH.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
