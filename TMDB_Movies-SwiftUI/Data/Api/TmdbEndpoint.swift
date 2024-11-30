//
//  TmdbEndpoint.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

enum TmdbEndpoint {
    case movie(id: Int, language: String)
    case moviesTop(page: Int, language: String)
    case poster(path: String)
    case posterSmall(path: String)
}

// MARK: - fields
extension TmdbEndpoint {

    var request: URLRequest? {
        guard let url = self.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 30
        request.allHTTPHeaderFields = [
          "accept": "application/json",
        ]

        return request
    }

    var url: URL? {
        switch self {
            case let .movie(id, language):
                getUrl(
                    path: "/\(id)",
                    query: [
                        Self.languageParam: language,
                    ]
                )
            case let .moviesTop(page, language):
                getUrl(
                    path: "/top_rated",
                    query: [
                        Self.pageParam: "\(page)",
                        Self.languageParam: language,
                    ]
                )
            case let .poster(path):
                getUrl(
                    url: Self.posterURL,
                    path: "/\(Self.posterBig)\(path)"
                    )
            case let .posterSmall(path):
                getUrl(
                    url: Self.posterURL,
                    path: "/\(Self.posterSmall)\(path)"
                    )
        }
    }

    var method: String {
        switch self {
            case .movie, .moviesTop, .poster, .posterSmall:
                return "GET"
        }
    }

}

extension TmdbEndpoint {
    public static let pageInit = 1
}

// MARK: - private
private extension TmdbEndpoint {
    func getUrl(url: String = Self.baseURL, path: String, query params: [String: String] = [:]) -> URL? {
        guard var components = URLComponents(string: url) else { return nil }

        components.path += path

        let queryItems = [toQueryItem(key: Self.apiKeyParam, value: Self.apiKey)]
        components.queryItems = queryItems + params.map(toQueryItem)

        return components.url
    }

    func toQueryItem(key: String, value: String) -> URLQueryItem {
        URLQueryItem(name: key, value: value)
    }

    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let posterURL = "https://image.tmdb.org/t/p"
    static let posterBig = "w500"
    static let posterSmall = "w92"
    // Query params
    static let pageParam = "page"
    static let languageParam = "language"
    static let apiKeyParam = "api_key"

    // api key
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "Please add your api key to the project"
}
