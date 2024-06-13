//
//  RoundView.swift
//
//  Created by Evgeniy K on 10.06.2024.
//

import SwiftUI

struct RoundView: View {
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        ZStack {
            VStack {
                NavigationHeader(
                    title: "Игра",
                    isRound: true,
                    isPaused: $vm.isPaused,
                    rightButtonAction: {
                        vm.isPaused.toggle()
                    },
                    leftButtonAction: {
                        withAnimation {
                            vm.resetGame()
                        }
                    }
                )
                // Верхняя картинка руки: female
                Text("\(vm.time)")
                Image(vm.femaleArm)
                    .resizableToFit()
                
                    Text("DRAW")
                    .font(.custom(.rubikMedium, size: 56))
                    .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                        .opacity(vm.isDraw ? 1 : 0)
                        .animation(.easeIn, value: vm.isDraw)
                
                // Нижняя картинка руки: male
                Image(vm.maleArm)
                    .resizableToFit()
            }
            
            HStack {
                TimeProgress()
                    .frame(height: vm.size.height/4)
                    .padding(10)
                    .environmentObject(vm)

                Spacer()

                ScaleView(height: vm.size.height/3)
                    .environmentObject(vm)
                    .padding(10)
            }
        }
        .overlay(alignment: .bottom) {
            GameButtons()
        }
        .onAppear {
            vm.setupTimer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoundView()
        .environmentObject(GameViewModel())
}
