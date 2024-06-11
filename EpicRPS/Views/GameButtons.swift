//
//  GameButtons.swift
//  EpicRPS
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct GameButtons: View {

    @State private var isButtonPressed: (paper: Bool, stone: Bool, scissors: Bool) = (false, false, false)
    @State private var playerChoice: String?
    @State private var multiplayer: Bool = false // если второй игрок - человек, то true

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Button "Камень"
                Button {
                    buttonPressed(button: "stone")
                } label: {
                    Image("stone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(isButtonPressed.stone ? 1.0 : 0.9)
                        .scaleEffect(isButtonPressed.stone ? 1.1 : 1.0)
                }
                .disabled(isButtonPressed.paper || isButtonPressed.stone || isButtonPressed.scissors)
            }

            VStack {
                // Button "Бумага"
                Button {
                    buttonPressed(button: "paper")
                } label: {
                    Image("paper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(isButtonPressed.paper ? 1.0 : 0.8)
                        .scaleEffect(isButtonPressed.paper ? 1.1 : 1.0)
                }
                .disabled(isButtonPressed.paper || isButtonPressed.stone || isButtonPressed.scissors)

                Spacer()

                // Кнопка смены игрока, если второй игрок - человек
                if let _ = playerChoice, multiplayer {
                    Button {
                        resetGame()
                    } label: {
                        Image("select")
                        //.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 80)
                            .opacity(isButtonPressed.scissors ? 1.0 : 0.8)
                    }
                }
            }

            VStack(alignment: .trailing) {
                // Button "Ножницы"
                Button {
                    buttonPressed(button: "scissors")
                } label: {
                    Image("scissors")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 80, maxHeight: 80)
                        .opacity(isButtonPressed.scissors ? 1.0 : 0.8)
                        .scaleEffect(isButtonPressed.scissors ? 1.1 : 1.0)
                }
                .disabled(isButtonPressed.paper || isButtonPressed.stone || isButtonPressed.scissors)
            }
        }
        .frame(maxWidth: 250, maxHeight: 150)
    }

    // Обработка нажатий
    private func buttonPressed(button: String) {
        switch button {
        case "paper":
            isButtonPressed.paper = true
        case "stone":
            isButtonPressed.stone = true
        case "scissors":
            isButtonPressed.scissors = true
        default:
            break
        }
        playerChoice = button
    }

    // Сброс состояния игры после нажатия
    private func resetGame() {
        isButtonPressed = (false, false, false)
        playerChoice = nil
    }
}

#Preview {
    GameButtons()
}

