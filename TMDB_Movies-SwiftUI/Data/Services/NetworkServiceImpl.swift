//
//  NetworkServiceImpl.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation

final class NetworkServiceImpl: NetworkService {
    
    private lazy var session = URLSession.shared
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
    // MARK: - Getting data from the network
    func fetchData<T>(endpoint: TmdbEndpoint) async -> Result<T, any Error> where T : Decodable {
        guard let request = endpoint.request else { return .failure(NetworkError.invalidRequest) }
        print("NetworkServiceImpl: \(#function) url: \(request.url?.absoluteString ?? "")")
        
        do {
            let data = try await fetchData(for: request)
            
            let result: T = if T.self == Data.self, let data = data as? T {
                data
            } else {
                try decode(data)
            }
            
            return .success(result)
            
        } catch let error as NetworkError {
            return .failure(error)
        } catch let error as DecodingError {
            return .failure(NetworkError.decodingError(error))
        } catch let error as URLError where error.code == .cancelled {
            return .failure(NetworkError.cancelled)
        } catch {
            print("NetworkServiceImpl: \(#function) error: \(error.localizedDescription)")
            return .failure(NetworkError.networkError(error))
        }
    }
    
    // MARK: - URLRequest
    private func fetchData(for reques: URLRequest) async throws -> Data {
        print("NewsServiceImpl: \(#function)")
        let (data, response) = try await session.data(for: reques)
        if let code = getErrorCode(for: response) {
            try getErrorMsg(code, from: data)
        }
        return data
    }
    
    // MARK: - Error handling
    private func getErrorCode(for response: URLResponse) -> Int? {
        print("NewsServiceImpl: \(#function)")
        guard let httpResponse = response as? HTTPURLResponse else { return -1 }
        
        return 200...299 ~= httpResponse.statusCode ? nil : httpResponse.statusCode
    }
    
    private func getErrorMsg(_ code: Int, from data: Data) throws {
        let message = if let response: ErrorResponse = try? decode(data) {
            "\(response.statusCode)-\(response.statusMessage)"
        } else {
            ""
        }
        print("NewsServiceImpl: \(#function) error: \(message)")
        throw NetworkError.invalidResponse(code: code, message: message)
    }
    
    // MARK: - Decode data
    private func decode<T>(_ data: Data) throws -> T where T: Decodable {
        try decoder.decode(T.self, from: data)
    }
}
