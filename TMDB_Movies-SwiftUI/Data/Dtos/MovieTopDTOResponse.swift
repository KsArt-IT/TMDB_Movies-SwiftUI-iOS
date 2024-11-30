//
//  MovieTopDTOResponse.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

struct MovieTopDTOResponse: Decodable {
    let page: Int
    let results: [MovieTopDTO]
    let totalPages: Int
    let totalResults: Int
}
