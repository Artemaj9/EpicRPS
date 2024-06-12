//
//  GameView.swift
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: GameViewModel
    
    var body: some View {
        ZStack {
            BackgroundView(gradientColor1: .gradient2Dark, gradientColor2: .gradient2Light)
            if vm.gamePhase == .loading {
                FightLoadScreen()
                    .runAfterAppear(delay: 3) {
                        vm.gamePhase = .round
                    }
            } else if vm.gamePhase == .round  {
                RoundView(
                )
                    .environmentObject(vm)
            } else {
                EndGameView()
                    .environmentObject(vm)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    GameView()
        .environmentObject(GameViewModel())
}
