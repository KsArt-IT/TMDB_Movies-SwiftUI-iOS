//
//  NetworkService.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

protocol NetworkService {
    func fetchData<T>(endpoint: TmdbEndpoint) async -> Result<T, any Error> where T: Decodable
}
