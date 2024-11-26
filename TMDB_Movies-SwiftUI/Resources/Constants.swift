//
//  Constants.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 26.11.2024.
//

import Foundation

enum Constants {
    static let appName: String = {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ??
        "TMDB Movies"
    }()
}
