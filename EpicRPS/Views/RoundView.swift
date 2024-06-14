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
                        if !vm.isPaused {
                            SoundService.player.avPlayer.pause()
                        } else {
                            SoundService.player.avPlayer.play()
                        }
                        vm.isPaused.toggle()
                    },
                    leftButtonAction: {
                        if let player = SoundService.player.avPlayer  {
                            player.stop()
                        }
                            vm.resetGame()
                            vm.gamePhase = .loading
                    }
                )
                // Верхняя картинка руки: female
                Image(vm.femaleArm)
                    .resizableToFit()
                
                StrokeAnimation()
                    .environmentObject(vm)
                
                
               
                ZStack {
                    Text("FIGHT")
                        .font(.custom(.rubikMedium, size: 56))
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                        .opacity(vm.time < 1 && !vm.isDraw && max(vm.player1Score, vm.player2Score) < 3 ? 1 : 0)
                    
                    Text("DRAW")
                        .font(.custom(.rubikMedium, size: 56))
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                        .opacity(vm.isDraw ? 1 : 0)
                        .animation(.easeIn, value: vm.isDraw)
                }
                
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
