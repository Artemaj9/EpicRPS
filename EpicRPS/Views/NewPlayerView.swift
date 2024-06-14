//
//  NewPlayerView.swift
//  EpicRPS
//
//  Created by Evgeniy K on 14.06.2024.
//

import SwiftUI

struct NewPlayerView: View {

    @EnvironmentObject var vm: GameViewModel
    @Environment (\.dismiss) var dismiss
    @State var name = "Player1"
    var checkBigLetters: Bool {
        name.count > 16
    }
    var checkLetters: Bool {
        name.count <= 2
    }
    @Binding var check: Bool

    @State var playerInd = 1

    var body: some View {

        VStack(spacing: 20) {

            HStack {
                Text("Введите имя игрока")
                    .font(.custom(.rubikRegular, size: 16))
                    .foregroundStyle(.rpsGray)
                Spacer()
            }

            TextField("Player1", text: $name)
                .font(.custom(.rubikMedium, size: 23))
                .padding(15)
                .background(.rpsLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.gray, lineWidth: 1)
                }

            HStack {
                ForEach(1..<5) { ind in
                    Button {
                        playerInd = ind
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(playerInd == ind ? .rpsScaleGreen : .rpsLightGray)
                            Image("character\(ind)")
                                .resizableToFit()
                                .frame(width: 29)
                            if playerInd == ind {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image("vmark-icon")
                                            .resizableToFit()
                                            .frame(width: 10)
                                            .offset(x: -8, y: -8)
                                    }
                                }
                            }
                        }
                        .frame(width: 63, height: 63)
                    }
                }
            }

            HStack {
                ForEach(5..<9) { ind in
                    Button {
                        playerInd = ind
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(playerInd == ind ? .rpsScaleGreen : .rpsLightGray)
                            Image("character\(ind)")
                                .resizableToFit()
                                .frame(width: 29)
                            if playerInd == ind {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image("vmark-icon")
                                            .resizableToFit()
                                            .frame(width: 10)
                                            .offset(x: -8, y: -8)
                                    }
                                }
                            }
                        }
                        .frame(width: 63, height: 63)
                    }
                }
            }

            Button(action: savePlayer) {
                Text("Сохранить")
                    .font(.custom(.rubikMedium, size: 20)).bold()
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                    .padding(13)
                    .frame(width: 145)
                    .background(.rpsPeachSettings)
                    .clipShape(.rect(cornerRadius: 18))
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 40)
    }

    private func savePlayer() {
        guard !checkBigLetters, !checkLetters else {
            return
        }
        let avatarName = "character\(playerInd)"
        vm.addNewPlayer(name: name, avatar: avatarName)
        dismiss()
    }
}

#Preview {
    NewPlayerView(check: .constant(true))
}
