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
                        .font(.custom(.rubikRegular, size: 25))
                        .opacity(0.7)
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
                    .stroke(lineWidth: 0.7)
                    .fill(.black.opacity(0.9)))
            .shadow(radius: 2, x: -1, y: 3)
            .padding()

            VStack {
                HStack {
                    Text("Фоновая музыка")
                        .lineLimit(1)
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
                .padding(12)
                .frame(idealWidth: .infinity, maxHeight: 60)
                .frame(maxWidth: .infinity)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
                .padding(EdgeInsets(top: 10, leading: 8, bottom: 5, trailing: 8))

                HStack {
                    // не понял задачу. куда ведет надатие на toggle?
                    Text("Игра с другом")
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)
                    Toggle("", isOn: $vm.multiplayer)
                    if playFriend {
                        // появляется секция друга?
                    }
                }
                .padding(12)
                .frame(idealWidth: .infinity, maxHeight: 60)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 10, trailing: 8))

            }
            .padding(7)
            .background(.white)
            .foregroundStyle(.primary)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 0.7)
                    .fill(.black))
            .shadow(radius: 2, x: -1, y: 3)
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
