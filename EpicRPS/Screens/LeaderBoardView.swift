//
//  LeaderBoardView.swift
//

import SwiftUI

struct LeaderBoardView: View {
    var body: some View {
        VStack {
            NavigationHeader(title: "Leaderboard")
                .frame(maxWidth: .infinity)
            Spacer()
            
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LeaderBoardView()
}
