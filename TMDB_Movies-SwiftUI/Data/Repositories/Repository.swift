//
//  Repository.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

protocol Repository: AnyObject {
    func fetchTopMoviesCount(language: String) async -> Result<(pages: Int, count: Int), Error>
    func fetchTopMovies(page: Int, language: String) async -> Result<[Movie], Error>
    func fetchMovie(id: Int, language: String) async -> Result<Movie, Error>
    func fetchMoviePoster(path: String, small: Bool) async -> Result<Data, Error>
}
