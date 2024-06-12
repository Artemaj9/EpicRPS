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
                // Button "Камень"
                Button {
                    vm.player1Selection = .rock
                    vm.isPaused = true
                    vm.startArmAnimation()
                } label: {
                    Image("stone")
                        .resizableToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(vm.player1Selection == .rock ? 1.0 : 0.9)
                        .scaleEffect(vm.player1Selection == .rock ? 1.1 : 1.0)
                }
                .disabled(vm.player1Selection != .notSelect)
            }

            VStack {
                // Button "Бумага"
                Button {
                    vm.player1Selection = .papper
                    vm.isPaused = true
                    vm.startArmAnimation()
                } label: {
                    Image("paper")
                        .resizableToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(vm.player1Selection == .papper ? 1.0 : 0.8)
                        .scaleEffect(vm.player2Selection == .papper ? 1.1 : 1.0)
                }
                .disabled(vm.player1Selection != .notSelect)

                Spacer()

                // Кнопка смены игрока, если второй игрок - человек
              //  if let _ = playerChoice, multiplayer {
//                    Button {
//                        resetGame()
//                    } label: {
//                        Image("select")
//                            .resizableToFit()
//                            .frame(maxWidth: 80, maxHeight: 80)
//                            .opacity(isButtonPressed.scissors ? 1.0 : 0.8)
//                    }
              //  }
            }

            VStack(alignment: .trailing) {
                // Button "Ножницы"
                Button {
                    vm.player1Selection = .scissors
                    vm.isPaused = true
                    vm.startArmAnimation()
                } label: {
                    Image("scissors")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(vm.player1Selection == .scissors ? 1.0 : 0.8)
                        .scaleEffect(vm.player1Selection == .papper ? 1.1 : 1.0)
                }
                .disabled(vm.player1Selection != .notSelect)
            }
        }
        .frame(maxWidth: 250, maxHeight: 150)
    }
}

#Preview {
    VStack {
        GameButtons()
            .environmentObject(GameViewModel())
    }
}

