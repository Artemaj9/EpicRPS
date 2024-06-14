//
//  LeaderBoardView.swift
//

import SwiftUI

struct LeaderBoardView: View {
    @EnvironmentObject var vm: GameViewModel
    var players2: [Player] {
        vm.allPlayers.sorted {
            $0.wins > $1.wins
        }
    }
    
    var playersTest = [Player(name: "Andrei", games: 3002, wins: 121, avatar: "avatarTest"),
                       Player(name: "Masha", games: 100, wins: 55, avatar: "avatarTest"),
                       Player(name: "Kate", games: 342, wins: 21, avatar: "avatarTest"),
                       Player(name: "Irina", games: 102, wins: 31, avatar: "avatarTest"),
                       Player(name: "Matew", games: 402, wins: 41, avatar: "avatarTest"),
                       Player(name: "Floa", games: 2402, wins: 51, avatar: "avatarTest"),
                       Player(name: "Inira", games: 12, wins: 11, avatar: "avatarTest"),
                       Player(name: "Russsasdsdna", games: 902, wins: 71, avatar: "avatarTest"),
                       Player(name: "Kksas", games: 3002, wins: 61, avatar: "avatarTest"),
                       Player(name: "Asksa", games: 3002, wins: 81, avatar: "avatarTest"),
                       Player(name: "Know", games: 3002, wins: 91, avatar: "avatarTest"),
                       Player(name: "Mew_mew_newsss", games: 3002, wins: 0, avatar: "avatarTest"),
    ]
    var players: [Player] {
        playersTest.sorted {
            $0.wins > $1.wins
        }
    }
    @State private var showName = false
    @State var showAvatar = false
    
    var body: some View {
        ZStack {
            
            VStack {
                NavigationHeader(title: "Leaderboard")
                    .frame(maxWidth: .infinity)
                HStack {
                    Button {
                        showAvatar.toggle()
                    } label: {
                        Image(vm.currentPlayer1.avatar)
                            .resizableToFit()
                    }
                    HStack{
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
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.rpsGray.opacity(0.2), lineWidth: 1)
                    }
                    Spacer()
                    
                }
                .frame(height: 46)
                .padding(.horizontal, 20)
                VStack {
                    ZStack {
                        VStack {
                            Color(.white)
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
                    .frame(height: 130)
                    
                    ScrollView {
                        
                        ForEach (players2.count == 0 ? players.indices: players2.indices) { ind in
                            let player = players[ind]
                            let points = player.wins * 500
                            let rate =  Double(player.wins) / (Double(player.games) / 100 )
                            LeaderBoardCell(placeInRankin: ( ind + 1 ), avatar: player.avatar, name: player.name, result: points, rate: Int(rate))
                            
                            if ind > 3 {
                                VStack{
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

    }
}

#Preview {
    LeaderBoardView()
        .environmentObject(GameViewModel())
}


