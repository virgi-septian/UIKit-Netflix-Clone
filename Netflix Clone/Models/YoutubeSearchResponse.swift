//
//  File.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 24/09/24.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    var items: [VieoElement]
}

struct VieoElement : Codable {
    let id: IdVideoElement
}

struct IdVideoElement : Codable {
    let kind: String
    let videoId: String
}

