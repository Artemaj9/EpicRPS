//
//  FightLoadScreen.swift
//

import SwiftUI

struct FightLoadScreen: View {
    @EnvironmentObject var vm: GameViewModel
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        ZStack {
            BackgroundView(gradientColor1: .gradient2Dark, gradientColor2: .gradient2Light)
            VStack {
                Spacer()

                playerView(player: vm.currentPlayer2)

                Text("VS")
                    .foregroundStyle(.rpsOrangeText)
                    .font(.custom(.rubikBold, size: 56))
                    .padding(.vertical, 30)

                playerView(player: vm.currentPlayer1)

                Spacer()

                animatedText
            }
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    counter += 1
                }
                if counter == getReady.count {
                    withAnimation(.spring()) {
                        counter = 0
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }

    private func playerView(player: Player) -> some View {
        VStack {
            Image(player.avatar)
                .resizableToFit()
                .frame(width: 87)
                .padding()

            HStack {
                Text("\(player.wins)")
                    .font(.custom(.rubikBold, size: 20))
                    .foregroundStyle(.rpsOrangeText)
                Text("Victories/")
                    .font(.custom(.rubikBold, size: 20))
                    .foregroundStyle(.white)
            }

            HStack {
                Text("\(player.games - player.wins)")
                    .font(.custom(.rubikBold, size: 20))
                    .foregroundStyle(.rpsRedGradientBG)
                Text("Lose")
                    .font(.custom(.rubikBold, size: 20))
                    .foregroundStyle(.white)
            }
        }
    }

    private var animatedText: some View {
        HStack(spacing: 0) {
            ForEach(getReady.indices, id: \.self) { ind in
                Text(getReady[ind])
                    .offset(y: counter == ind ? -20 : 0)
            }
        }
        .foregroundStyle(.rpsOrangeText)
        .font(.custom(.rubikMedium, size: 23))
    }
}

private let getReady = ["G", "e", "t", " ", "r", "e", "a", "d", "y", ".", ".", "."]

#Preview {
    FightLoadScreen()
        .environmentObject(GameViewModel())
}
