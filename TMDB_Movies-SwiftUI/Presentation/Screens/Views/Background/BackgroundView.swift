//
//  BackgroundView.swift
//  TMDB_Movies-SwiftUI
//
//  Created by KsArT on 26.11.2024.
//

import SwiftUI

struct BackgroundView: View {
    @State var tilt: BackgroundSelector?
    
    var body: some View {
        LinearGradient(
            colors: [.first, .second, .third],
            startPoint: tilt?.getStartState() ?? .top,
            endPoint: tilt?.getEndState() ?? .bottom
        )
        .ignoresSafeArea()
        .task(id: tilt) {
            nextState()
        }
        .onAppear {
            nextState()
        }
    }
    
    private func nextState() {
        guard let tilt else { return }

        withAnimation {
            self.tilt = tilt.next()
        }
    }
}

#Preview {
    BackgroundView()
}
