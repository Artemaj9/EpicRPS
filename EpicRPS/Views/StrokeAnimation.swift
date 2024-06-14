//
//  StrokeAnimation.swift
//

import SwiftUI

struct StrokeAnimation: View {
    @EnvironmentObject var vm: GameViewModel
    
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image(systemName: "hexagon.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                    .scaleEffect(0.001)
                    .opacity(0.001)
                    .particleEffect(
                        systemImage: "hexagon.fill",
                        font: .footnote,
                        status: vm.isStrokeAnimation,
                        color: .red
                    )
            }
        }

    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        StrokeAnimation()
            .environmentObject(GameViewModel())
    }
}
