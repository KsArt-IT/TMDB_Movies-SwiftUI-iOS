//
//  MovieDTO.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let originalLanguage: String?
    let releaseDate: String?

    let genres: [MovieGenreDTO]

    let posterPath: String?
    let backdropPath: String?

    let overview: String?

    let genreIds: [Int]?

    let adult: Bool?
    let popularity: Double?
    let voteCount: Int?
    let voteAverage: Double?

    let video: Bool?
}

extension MovieDTO {

    func mapToDomain() -> Movie {
        Movie(
            id: self.id,
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            originalLanguage: self.originalLanguage ?? "",
            releaseDate: self.releaseDate ?? "",
            genres: self.genres.compactMap { $0.name },
            posterPath: self.posterPath ?? "",
            backdropPath: self.backdropPath ?? "",
            overview: self.overview ?? "",
            genreIds: self.genreIds ?? [],
            adult: self.adult ?? false,
            popularity: self.popularity ?? Double.nan,
            voteCount: self.voteCount ?? 0,
            voteAverage: self.voteAverage ?? 0,
            video: self.video ?? false
        )
    }
}
