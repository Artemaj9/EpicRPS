//
//  SettingsView.swift
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var vm = GameViewModel()

    @State private var selectedGameTime: Int? = nil
    @State private var playFriend = false

    var body: some View {

        VStack {
            VStack {
                HStack {
                    Text("время игры")
                        .font(.custom(.rubikRegular, size: 30))
                        .textCase(.uppercase)
                        .padding([.leading, .top])
                    Spacer()
                }

                HStack {
                    SettingsButton(text: "30 сек.") {
                        selectedGameTime = 30
                        vm.gameTime = 30
                    }

                    Spacer()

                    SettingsButton(text: "60 сек.") {
                        selectedGameTime = 60
                        vm.gameTime = 60
                    }
                }
                .padding()
            }
            .padding(7)
            .background(.white)
            .foregroundStyle(.primary)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
                    .fill(.black.opacity(0.9)))
            .shadow(radius: 20)
            .padding()

            VStack {
                HStack(spacing: 15) {
                    Text("Фоновая музыка")
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)

                    Spacer()

                    // посмотрите пожалуйста действие кнопки по выбору мелодии
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack {
                            Text("Мелодия 1")
                                .foregroundColor(.white)

                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                    })
                }
                .shadow(radius: 5)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(.rpsOrange)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: Color.rpsOrange.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding()

                HStack(spacing: 15) {
                    // не понял задачу. куда ведет надатие на toggle?
                    Text("Игра с другом")
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)
                    Toggle("", isOn: $playFriend)
                    if playFriend {
                        // появляется секция друга?
                    }
                }
                .shadow(radius: 5)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(.rpsOrange)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: Color.rpsOrange.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding()

            }
            .padding(7)
            .background(.white)
            .foregroundStyle(.primary)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
                    .fill(.black.opacity(0.9)))
            .shadow(radius: 20)
            .padding()
        }
        Spacer()
    }
}

#Preview {
    SettingsView()
}
