//
//  GameButtons.swift
//  EpicRPS
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct GameButtons: View {
    @EnvironmentObject var vm: GameViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                gameButton(selection: .rock, imageName: "stone")
            }

            VStack {
                gameButton(selection: .papper, imageName: "paper")

                Spacer()

                if vm.multiplayer {
                    switchPlayerButton()
                }
            }

            VStack(alignment: .trailing) {
                gameButton(selection: .scissors, imageName: "scissors")
            }
        }
        .frame(maxWidth: 250, maxHeight: 150)
    }

    private func gameButton(selection: Selection, imageName: String) -> some View {
        Button {
            handleSelection(selection)
        } label: {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80, maxHeight: 80)
                .opacity(vm.player1Selection == selection && !vm.multiplayer ? 1.0 : 0.8)
                .scaleEffect(vm.player1Selection == selection && !vm.multiplayer ? 1.1 : 1.0)
                .colorMultiply(vm.player1Selection == selection && !vm.multiplayer ? buttonColor[selection.rawValue] : Color.white)
        }
        .disabled(vm.player1Selection != .notSelect && vm.player2Selection != .notSelect)
    }

    private func handleSelection(_ selection: Selection) {
        SoundService.player.strokePlayer.play()
        if !vm.multiplayer {
            vm.player1Selection = selection
            vm.isPaused = true
            vm.startArmAnimation()
        } else {
            if !vm.secondPlayerTurn {
                vm.player1Selection = selection
                vm.isPaused = true
            } else {
                vm.player2Selection = selection
                vm.isPaused = true
                vm.startArmAnimation()
            }
        }
    }

    private func switchPlayerButton() -> some View {
        Button {
            vm.secondPlayerTurn = true
            vm.time = 0
            vm.isPaused = false
            SoundService.player.play(key: .tap, isHit: true)
        } label: {
            Image("select")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80, maxHeight: 80)
        }
        .disabled(vm.secondPlayerTurn || vm.player1Selection == .notSelect)
    }
}
private let buttonColor: [Color] = [.rpsLightPeach, .rpsRedGradientBG, .rpsScaleGreen]
#Preview {
    VStack {
        GameButtons()
            .environmentObject(GameViewModel())
    }
}
