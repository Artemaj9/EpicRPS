//
//  LeaderBoardView.swift
//

import SwiftUI

struct LeaderBoardView: View {
    @EnvironmentObject var vm: GameViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showName = false
    @State private var showAvatar = false

    var body: some View {
        ZStack {
            VStack {
                NavigationHeader(title: "Leaderboard")
                    .frame(maxWidth: .infinity)

                playerInfo
                    .frame(height: 46)
                    .padding(.horizontal, 20)

                leaderboard
                    .animation(.easeInOut(duration: 1), value: showName)
                    .animation(.easeInOut(duration: 1), value: showAvatar)
            }
            .blur(radius: showName || showAvatar ? 5 : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.rpsLightGray)
            .navigationBarHidden(true)

            if showName {
                NameEditingView(check: $showName)
                    .environmentObject(vm)
                    .shadow(radius: 20)
                    .transition(.scale)
            }

            if showAvatar {
                AvatarSelectionView(check: $showAvatar)
                    .environmentObject(vm)
                    .shadow(radius: 20)
                    .transition(.scale)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 5.0, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width > 50 && abs(value.translation.height) < 50 {
                        dismiss()
                    }
                }
        )
    }

    private var playerInfo: some View {
        HStack {
            Button {
                showAvatar.toggle()
            } label: {
                Image(vm.currentPlayer1.avatar)
                    .resizableToFit()
            }

            HStack {
                Button {
                    showName.toggle()
                } label: {
                    Text(vm.currentPlayer1.name)
                        .font(.custom(.rubikMedium, size: 20))
                        .foregroundStyle(.rpsGray)
                        .padding(13)
                }
                .padding(.horizontal, 10)

                Spacer()
            }
            .frame(width: 249)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.rpsGray.opacity(0.2), lineWidth: 1)
            )
            Spacer()
        }
    }

    private var leaderboard: some View {
        VStack {
            leaderboardHeader
                .frame(height: 130)

            ScrollView {
                ForEach(Array(vm.allPlayers.sorted(by: >).enumerated()), id: \.offset) {
                    (ind, player) in
                    let points = player.wins * 500
                    let rate = Double(player.wins) / (Double(max(player.games, 1)) / 100)
                    LeaderBoardCell(
                        placeInRankin: (ind + 1), avatar: player.avatar, name: player.name,
                        result: points,
                        rate: Int(rate)
                    )
                    .id(player.name)

                    if ind > 3 {
                        VStack {
                            Rectangle()
                                .foregroundStyle(.rpsTextForCell.opacity(0.3))
                                .frame(width: 250, height: 0.3)
                            Spacer()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }

    private var leaderboardHeader: some View {
        ZStack {
            VStack {
                Color.white
                    .padding(2)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                    .offset(y: 30)
                    .padding(2)
            }
            Rectangle()
                .foregroundColor(.white)
                .offset(y: 90)
                .padding(2)
            VStack {
                Image("topImage")
                    .resizableToFit()
                    .frame(height: 95)
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Text("Игроки")
                        .font(.custom(.rubikMedium, size: 15))
                        .foregroundStyle(.rpsDefaultTextForCell)
                    Spacer()
                    Text("Очки")
                        .font(.custom(.rubikMedium, size: 15))
                        .foregroundStyle(.rpsDefaultTextForCell)
                        .padding(.horizontal, 15)
                    Text("Рейтинг")
                        .font(.custom(.rubikMedium, size: 15))
                        .foregroundStyle(.rpsDefaultTextForCell)
                        .padding(.horizontal, 5)
                }
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    LeaderBoardView()
        .environmentObject(GameViewModel())
}
