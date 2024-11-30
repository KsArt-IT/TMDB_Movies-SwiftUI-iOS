//
//  ErrorResponse.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

struct ErrorResponse: Decodable {
    let statusCode: Int
    let statusMessage: String //"Invalid API key: You must be granted a valid key."
    let success: Bool
}
