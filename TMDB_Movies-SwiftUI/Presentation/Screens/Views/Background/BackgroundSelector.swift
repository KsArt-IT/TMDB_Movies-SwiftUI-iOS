//
//  BackgroundSelector.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 26.11.2024.
//

import SwiftUICore

enum BackgroundSelector: Hashable {
    case leading
    case center(_ start: Bool)
    case trailing
}

extension BackgroundSelector {
    func next() -> Self {
        switch self {
        case .leading:
                .center(true)
        case .center(let start):
            start ? .trailing : .leading
        case .trailing:
                .center(false)
        }
    }
    
    func getStartState() -> UnitPoint {
        switch self {
        case .leading:
                .topLeading
        case .center:
                .top
        case .trailing:
                .topTrailing
        }
    }
    
    func getEndState() -> UnitPoint {
        switch self {
        case .leading:
                .bottomTrailing
        case .center:
                .bottom
        case .trailing:
                .bottomLeading
        }
    }
}
