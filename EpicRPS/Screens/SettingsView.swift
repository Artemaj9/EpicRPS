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
    @State private var selection = "Piano"
    var music = ["Piano", "Guitar", "Bop", "NewJaz", "Tartan", "Blue",
                 "Pink", "Gray2", "Lii", "Latina", "Violin", "Sitar",
                 "Banjo", "Green", "Blu1e", "B", "Drums", "Pipe",
                 "Pink", "Gray", "Lii", "Purple1", "Rain", "Style"]
    @State var index = 0

    var body: some View {
        VStack {
            NavigationHeader(title: "Settings")
                .frame(maxWidth: .infinity)

            // MARK: - Блок выбора времени игры

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

            // MARK: - Блок выбора музыки и игрока

            VStack {
                HStack {
                    Text("Фоновая музыка")
                        .lineLimit(1)
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)

                    Spacer()

                    // MARK: - Кнопка (меню) выбора мелодии

                    Menu {
                        ForEach(Array(music.enumerated()), id: \.offset) { index, mus in
                            Button(
                                action: {
                                    self.index = index
                                    self.selection = mus
                                },
                                label: {
                                    HStack {
                                        Text(mus)
                                        if selection == music[index] {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                })
                        }
                    } label: {
                        HStack {
                            Text(selection)
                            Image(systemName: "chevron.right")

                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / 6)
                    }
                }
                .padding(12)
                .frame(idealWidth: .infinity, maxHeight: 60)
                .frame(maxWidth: .infinity)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))

                // MARK: - Секция выбора режима мультиплеера

                HStack {
                    Text("Игра с другом")
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)
                    Toggle("", isOn: $vm.multiplayer)
                }
                .padding(12)
                .frame(idealWidth: .infinity, maxHeight: 60)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))

                // MARK: - Секция выбора Игрока 1

                HStack {
                    Text("Игрок 1")
                        .font(.custom(.rubikMedium, size: 18))
                        .foregroundStyle(.white)

                    Spacer()

                    HStack {
                        Text(vm.currentPlayer1.name)
                            .font(.custom(.rubikMedium, size: 20))
                            .foregroundStyle(.secondary)

                        Image(vm.currentPlayer1.avatar)
                            .resizableToFit()
                            .frame(width: 30, height: 30, alignment: .center)

                        // MARK: - Кнопка (меню) выбора Игрока 1

                        Menu {
                            // FIXME: 1 - поправьте пожалуйста код для доступа к списку игроков
                            //                            ForEach($players, id: \.name) { player in
                            //                                Button(
                            //                                    action: {
                            //                                        //self.index = index
                            //                                        self.selection = player.name
                            //                                    },
                            //                                    label: {
                            //                                        HStack {
                            //                                            Text(player.name)
                            //                                            if selection == player[index] {
                            //                                                Image(systemName: "checkmark")
                            //                                            }
                            //                                        }
                            //                                    })
                            //                            }
                        } label: {
                            HStack {
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
                .padding(12)
                .frame(idealWidth: .infinity, maxHeight: 60)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
                .padding(vm.multiplayer ? EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10) : EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))

                // MARK: - Секция выбора Игрока 2

                if vm.multiplayer {
                    HStack {
                        Text("Игрок 2")
                            .font(.custom(.rubikMedium, size: 18))
                            .foregroundStyle(.white)

                        Spacer()

                        HStack {
                            Text(vm.currentPlayer2.name)
                                .font(.custom(.rubikMedium, size: 20))
                                .foregroundStyle(.secondary)

                            Image(vm.currentPlayer2.avatar)
                                .resizableToFit()
                                .frame(width: 30, height: 30, alignment: .center)

                            // MARK: - Кнопка (меню) выбора Игрока 2

                            Menu {
                                // FIXME: 2 - поправьте пожалуйста код для доступа к списку игроков
                                // your code here
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(12)
                    .frame(idealWidth: .infinity, maxHeight: 60)
                    .background(.rpsPeachSettings)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                }
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
