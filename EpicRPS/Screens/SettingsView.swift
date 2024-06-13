//
//  SettingsView.swift
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var vm: GameViewModel

    @State private var selectedGameTime: Int? = nil
    @State private var playFriend = false

    var body: some View {
        VStack {
            NavigationHeader(title: "Settings")
                .frame(maxWidth: .infinity)
            VStack {
                HStack {
                    Text("время игры")
                        .font(.custom(.rubikRegular, size: 30))
                        .textCase(.uppercase)
                        .padding([.leading, .top])
                    Spacer()
                }

                HStack {
                    SettingsButton(text: "10 сек.") {
                        selectedGameTime = 10
                        vm.gameTime = 10
                    }
                    .hueRotation(Angle(degrees: vm.gameTime == 10 ?  75 : 0))

                    Spacer()

                    SettingsButton(text: "20 сек.") {
                        selectedGameTime = 20
                        vm.gameTime = 20
                    }
                    .hueRotation(Angle(degrees: vm.gameTime == 20 ?  75 : 0))
                }
                .padding()
                .animation(.smooth, value: vm.gameTime)
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
                    Toggle("", isOn: $vm.multiplayer)
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
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingsView()
        .environmentObject(GameViewModel())
}
