//
//  SettingsView.swift
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: GameViewModel
    @State var index = 0
    @State var addNewPlayer = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                NavigationHeader(title: "Settings")
                    .frame(maxWidth: .infinity)
                
                gameTimeSelection
                    .padding(.horizontal)
                
                musicAndPlayerSelection
                    .padding()
                
                // добавление нового игрока
                VStack {
                    HStack {
                        Text("Новый игрок")
                            .font(.custom(.rubikMedium, size: 18))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button {
                            addNewPlayer = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizableToFit()
                                .foregroundStyle(.white)
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 1)
                        }
                        .sheet(isPresented: $addNewPlayer) {
                            NewPlayerView(check: .constant(true))
                        }
                    }
                    .hStackStyle()
                    .padding(.bottom, 15)
                }
                .settingsStyle()
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .animation(.easeInOut, value: vm.multiplayer)
        .navigationBarHidden(true)
    }

    private var gameTimeSelection: some View {
        VStack {
            sectionHeader(text: "время игры")

            HStack {
                SettingsButton(text: "10 сек.") {
                    vm.gameTime = 10
                }
                .hueRotation(Angle(degrees: vm.gameTime == 10 ? 75 : 0))

                Spacer()

                SettingsButton(text: "20 сек.") {
                    vm.gameTime = 20
                }
                .hueRotation(Angle(degrees: vm.gameTime == 20 ? 75 : 0))
            }
            .padding()
            .animation(.smooth, value: vm.gameTime)
        }
        .settingsStyle()
    }

    private var musicAndPlayerSelection: some View {
        VStack {
            musicSelection
            multiplayerToggle
            playerSelection(player: vm.currentPlayer1, label: "Игрок 1") { selectedPlayer in
                if vm.currentPlayer2 != selectedPlayer {
                    vm.currentPlayer1 = selectedPlayer
                }
            }
            if vm.multiplayer {
                playerSelection(player: vm.currentPlayer2, label: "Игрок 2") { selectedPlayer in
                    if vm.currentPlayer1 != selectedPlayer {
                        vm.currentPlayer2 = selectedPlayer
                    }
                }
            }
        }
        .settingsStyle()
    }

    private var musicSelection: some View {
        HStack {
            Text("Фоновая музыка")
                .lineLimit(1)
                .font(.custom(.rubikMedium, size: 18))
                .foregroundStyle(.white)

            Spacer()

            Menu {
                ForEach(Array(bgMusic.enumerated()), id: \.offset) { index, mus in
                    Button(action: {
                        vm.backGroundMusic = mus
                    }) {
                        HStack {
                            Text(mus.capitalized)
                            if vm.backGroundMusic == mus {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Spacer()
                    Text(vm.backGroundMusic.capitalized)
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.white)
                .frame(width: vm.size.width / 3, alignment: .leading)
            }
        }
        .hStackStyle()
    }

    private var multiplayerToggle: some View {
        HStack {
            Text("Игра с другом")
                .font(.custom(.rubikMedium, size: 18))
                .foregroundStyle(.white)
            Toggle("", isOn: $vm.multiplayer)
                .onChange(of: vm.multiplayer) { value in
                    if value {
                        vm.currentPlayer2 = vm.allPlayers.first(where: {$0.name != "Computer" && $0.name != vm.currentPlayer1.name}) ?? Player(name: "Player2", avatar: "character6")
                    }

            }
        }
        .hStackStyle()
    }

    private func playerSelection(player: Player, label: String, action: @escaping (Player) -> Void) -> some View {
        HStack {
            Text(label)
                .font(.custom(.rubikMedium, size: 18))
                .foregroundStyle(.white)

            Spacer()

            HStack {
                Text(player.name)
                    .font(.custom(.rubikMedium, size: 20))
                    .foregroundStyle(.secondary)

                Image(player.avatar)
                    .resizableToFit()
                    .frame(width: 30, height: 30)

                Menu {
                    ForEach(Array(vm.allPlayers.enumerated()), id: \.offset) { index, player in
                        Button(action: {
                            action(player)
                        }) {
                            HStack {
                                Text(player.name.capitalized)
                                if (label == "Игрок 1" && vm.currentPlayer1 == player) ||
                                   (label == "Игрок 2" && vm.currentPlayer2 == player) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
            }
        }
        .hStackStyle()
        .padding(.bottom, vm.multiplayer ? 0 : 15)
    }

    private func sectionHeader(text: String) -> some View {
        HStack {
            Text(text)
                .font(.custom(.rubikRegular, size: 25))
                .opacity(0.7)
                .textCase(.uppercase)
                .padding([.leading, .top])
                .foregroundStyle(.black)
            Spacer()
        }
    }
}

private extension View {
    func settingsStyle() -> some View {
        self
            .padding(7)
            .background(.white)
            .foregroundStyle(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 0.7)
                    .fill(.black.opacity(0.9)))
            .shadow(radius: 2, x: -1, y: 3)
    }
}

private extension View {
    func hStackStyle() -> some View {
        self
            .padding(12)
            .frame(maxHeight: 60)
            .background(.rpsPeachSettings)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 10)
            .padding(.top, 15)
    }
}

private let bgMusic = Sounds.music.map { $0.rawValue }

#Preview {
    SettingsView()
        .environmentObject(GameViewModel())
}
