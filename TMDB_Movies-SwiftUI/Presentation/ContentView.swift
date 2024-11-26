//
//  ContentView.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 01.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background {
            BackgroundView(tilt: .leading)
        }
    }
}

#Preview {
    ContentView()
}
