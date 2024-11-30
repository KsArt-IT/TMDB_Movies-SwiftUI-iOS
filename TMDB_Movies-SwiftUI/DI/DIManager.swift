//
//  DIManager.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 30.11.2024.
//

import Foundation
import Swinject

final class DIManager {
    private let container = Container()
    
    // MARK: - Registering dependencies
    init() {
        registerRepository()
    }
    
    // MARK: - Repository
    private func registerRepository() {
        container.register(NetworkService.self) { _ in
            NetworkServiceImpl()
        }.inObjectScope(.weak)
        
        container.register(Repository.self) { c in
            RepositoryImpl(service: c.resolve(NetworkService.self)!)
        }.inObjectScope(.container)
    }
    
    
    // MARK: - Getting dependencies
    public func resolve<T>() -> T {
        resolve(T.self)!
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        container.resolve(type)
    }
}
