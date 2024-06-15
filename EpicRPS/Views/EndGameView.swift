//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject var vm: GameViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            ZStack{
                
                if vm.multiplayer {
                    Image(vm.winner == 1 ? vm.currentPlayer1.avatar : vm.currentPlayer2.avatar)
                        .resizableToFit()
                        .frame(width: 70)
                } else {
                    Circle()
                        .foregroundStyle(.rpsDarkVioletEnd)
                    Image (vm.currentPlayer1.avatar)
                        .resizableToFit()
                        .frame(width: 70)
                }
                    
            }
            .frame(width: 176, height: 176)
            VStack(spacing: 20) {
                if vm.multiplayer {
                    Text(vm.winner == 1 ? "\(vm.currentPlayer1.name) win!" : "\(vm.currentPlayer2.name) win!")
                        .font(.custom("Rubik-Medium", size: 25))
                        .foregroundStyle(.white)
                } else {
                    Text(vm.winner == 1 ? "You Win" : "You Lose")
                        .font(.custom("Rubik-Medium", size: 25))
                        .foregroundStyle( vm.winner == 1 ? .rpsOrangeText : .black )
                }
                    Text("\(vm.player1Score) - \(vm.player2Score)")
                        .font(.custom("Rubik-Bold", size: 45))
                        .foregroundStyle(.white)
            }
            .padding()
            HStack (spacing: 40){
                //Buttons
                //Button home
                Button {
                    vm.resetGame()
                    vm.gamePhase = .loading
                    if let  player =  SoundService.player.avPlayer {
                        player.stop()
                        dismiss()
                    }
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(.rpsSkinnyButton)
                            .shadow(color: .rpsDarkSkinnyButton, radius: 0, y: 6)
                        Image("home-icon")
                            .resizableToFit()
                            .frame(width: 20)
                    }
                    .frame(width: 67, height: 52)
                }
                //Button replay
                Button {
                    vm.resetGame()
                     vm.gamePhase = .round
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(.rpsSkinnyButton)
                            .shadow(color: .rpsDarkSkinnyButton, radius: 0, y: 6)
                        Image("replay-icon")
                            .resizableToFit()
                            .frame(width: 20)
                    }
                    .frame(width: 67, height: 52)
                }
            }
        }
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .radialGradient(
                colors: {
                    if vm.multiplayer {
                        return [.rpsdarkgrad, .rpslightgrad]
                    } else if vm.winner == 2 {
                        return [.rpsOrangeGradientBG, .rpsRedGradientBG]
                    } else {
                        return [.rpsDarkBlueGradientBG, .rpsBlueGradientBG]
                    }
                }(),
                center: .center,
                startRadius: 1,
                endRadius: 720
            )
        )
    }
}
