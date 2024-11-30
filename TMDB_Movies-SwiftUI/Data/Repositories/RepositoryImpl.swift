//
//  RepositoryImpl.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

final class RepositoryImpl: Repository {

    private let service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func fetchTopMoviesCount(language: String) async -> Result<(pages: Int, count: Int), any Error> {
        let result: Result<MovieTopDTOResponse, Error> = await service.fetchData(
            endpoint: .moviesTop(page: TmdbEndpoint.pageInit, language: language)
        )
        return switch result {
            case .success(let movieTopDTOs):
                .success((pages: movieTopDTOs.totalPages, count: movieTopDTOs.totalResults))
            case .failure(let error):
                .failure(error)
        }
    }

    func fetchTopMovies(page: Int, language: String) async -> Result<[Movie], Error> {
        let result: Result<MovieTopDTOResponse, Error> = await service.fetchData(
            endpoint: .moviesTop(page: page, language: language)
        )
        return switch result {
            case .success(let movieTopDTOs):
                .success(movieTopDTOs.results.map { $0.mapToDomain() })
            case .failure(let error):
                .failure(error)
        }
    }

    func fetchMovie(id: Int, language: String) async -> Result<Movie, any Error> {
        let result: Result<MovieDTO, Error> = await service.fetchData(
            endpoint: .movie(id: id, language: language)
        )
        return switch result {
            case .success(let movieDTO):
                .success(movieDTO.mapToDomain())
            case .failure(let error):
                .failure(error)
        }
    }

    func fetchMoviePoster(path: String, small: Bool) async -> Result<Data, any Error> {
        let result: Result<Data, Error> = await service.fetchData(
            endpoint: small ? .posterSmall(path: path): .poster(path: path)
        )
        return switch result {
            case .success(let data):
                .success(data)
            case .failure(let error):
                .failure(error)
        }
    }
}
