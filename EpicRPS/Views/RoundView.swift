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
                    .offset(y: vm.strokeTime < 1 ? 40 * vm.strokeTime : 40)
                
                CustomAnimation()
                    .environmentObject(vm)
                    .opacity(vm.strokeTime <= 0.7 ? 0 : (vm.strokeTime - 0.7)/0.8)
                   // .blur(radius: 2)
                    .offset(y: vm.size.height*0.05)
                    .animation(.easeInOut, value: vm.strokeTime)
                
                
               
                ZStack {
                    Text("FIGHT")
                        .font(.custom(.rubikMedium, size: 56))
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                        .opacity(vm.time < 1 && !vm.isDraw && max(vm.player1Score, vm.player2Score) < 3 && vm.player1Selection == .notSelect ? 1 : 0)
                    
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
                    .offset(y: vm.strokeTime < 1 ? -40 * vm.strokeTime : -40)
            }
            .animation(.easeOut, value: vm.strokeTime)
            
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
                .environmentObject(vm)
        }
        .onAppear {
            vm.setupTimer()
            SoundService.player.preloadAudio(file: "tap")
            SoundService.player.preloadAudio(file: "crash", isStroke: false)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoundView()
        .environmentObject(GameViewModel())
}
