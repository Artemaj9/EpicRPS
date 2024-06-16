//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject var vm: GameViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            avatar
                .frame(width: 176, height: 176)

            gameResult
                .padding()

            returnButtons
        }
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .radialGradient(
                colors: gradientColors,
                center: .center,
                startRadius: 1,
                endRadius: 720
            )
        )
    }

    private var avatar: some View {
        ZStack {
            if !vm.multiplayer {
                Circle()
                    .foregroundStyle(.rpsDarkVioletEnd)
            }
                Image(vm.winner == 1 ? vm.currentPlayer1.avatar : vm.currentPlayer2.avatar)
                    .resizableToFit()
                    .frame(width: 70)
        }
    }

    private var gameResult: some View {
        VStack(spacing: 20) {
            if vm.multiplayer {
                Text(
                    vm.winner == 1
                        ? "\(vm.currentPlayer1.name) win!" : "\(vm.currentPlayer2.name) win!"
                )
                .font(.custom("Rubik-Medium", size: 25))
                .foregroundStyle(.white)
            } else {
                Text(vm.winner == 1 ? "You Win" : "You Lose")
                    .font(.custom("Rubik-Medium", size: 25))
                    .foregroundStyle(vm.winner == 1 ? .rpsOrangeText : .black)
            }
            Text("\(vm.player1Score) - \(vm.player2Score)")
                .font(.custom("Rubik-Bold", size: 45))
                .foregroundStyle(.white)
        }
    }

    private var returnButtons: some View {
        HStack(spacing: 40) {
            homeButton
            replayButton
        }
    }

    private var homeButton: some View {
        Button {
            vm.resetGame()
            vm.gamePhase = .loading
            if let player = SoundService.player.avPlayer {
                player.stop()
                dismiss()
            }
        } label: {
            buttonStyle(imageName: "home-icon")
        }
    }

    private var replayButton: some View {
        Button {
            vm.resetGame()
            vm.gamePhase = .round
        } label: {
            buttonStyle(imageName: "replay-icon")
        }
    }

    private func buttonStyle(imageName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.rpsSkinnyButton)
                .shadow(color: .rpsDarkSkinnyButton, radius: 0, y: 6)
            Image(imageName)
                .resizableToFit()
                .frame(width: 20)
        }
        .frame(width: 67, height: 52)
    }

    private var gradientColors: [Color] {
        if vm.multiplayer {
            return [.rpsdarkgrad, .rpslightgrad]
        } else if vm.winner == 2 {
            return [.rpsOrangeGradientBG, .rpsRedGradientBG]
        } else {
            return [.rpsDarkBlueGradientBG, .rpsBlueGradientBG]
        }
    }
}

#Preview {
    EndGameView()
        .environmentObject(GameViewModel())
}
