//
//  FightLoadScreen.swift
//

import SwiftUI

struct FightLoadScreen: View {
    @EnvironmentObject var vm: GameViewModel
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        ZStack{
            BackgroundView(gradientColor1: .gradient2Dark, gradientColor2: .gradient2Light)
            VStack {
                Spacer()
                VStack {
                    Image(vm.currentPlayer2.avatar)
                        .resizableToFit()
                        .frame(width: 87)
                        .padding()
                    
                    HStack {
                        Text("\(vm.currentPlayer2.wins)")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.rpsOrangeText)

                        Text("Victories/")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.white)
                    }
                    HStack {
                        Text("\(vm.currentPlayer2.games - vm.currentPlayer2.wins)")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.rpsRedGradientBG)

                        Text("Lose")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.white)
                    }
                }
                Text("VS")
                    .foregroundStyle(.rpsOrangeText)
                    .font(.custom(.rubikBold, size: 56))
                    .padding(.vertical, 30)
                VStack {
                    Image(vm.currentPlayer1.avatar)
                        .resizableToFit()
                        .frame(width: 87)
                        .padding()
                    HStack {
                        Text("\(vm.currentPlayer1.wins)")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.rpsOrangeText)
                        Text("Victories/")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.white)
                    }
                    HStack {
                        Text("\(vm.currentPlayer1.games - vm.currentPlayer1.wins)")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.rpsRedGradientBG)
                        Text("Lose")
                            .font(.custom(.rubikBold, size: 20))
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
                HStack(spacing: 0) {
                ForEach(getReady.indices) { ind in
                        Text(getReady[ind])
                            .offset(y: counter == ind ? -20 : 0)
                    }
                }
                .foregroundStyle(.rpsOrangeText)
                .font(.custom(.rubikMedium, size: 23))
                 
            }
            .onReceive(timer, perform: { _ in
                withAnimation(.spring()) {
                        counter += 1
                    }
                if counter == 12 {
                    withAnimation(.spring()) {
                        counter = 0
                    }
                }
            })
            .preferredColorScheme(.dark)
        }
    }
}

private let getReady = ["G", "e", "t", " ", "r", "e", "a", "d", "y", ".", ".", "."]
//#Preview {
//    FightLoadScreen()
//        .environmentObject(GameViewModel())
//}
