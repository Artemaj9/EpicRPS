//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    var win: Bool { scorePlayer1 > scorePlayer2 }
    var avatarImageName: String
    var scorePlayer1 : Int
    var scorePlayer2 : Int
  
    @EnvironmentObject var vm: GameViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundStyle(.rpsDarkVioletEnd)
                Image (avatarImageName)
                    .resizableToFit()
                    .frame(width: 70)
                    
            }
            .frame(width: 176, height: 176)
            VStack(spacing: 20) {
                Text(win ? "You Win" : "You Lose")
                    .font(.custom("Rubik-Medium", size: 25))
                    .foregroundStyle( win ? .rpsOrangeText : .black )
                Text("\(scorePlayer1) - \(scorePlayer2)")
                    .font(.custom("Rubik-Bold", size: 45))
                    .foregroundStyle(.white)
                
            }
            .padding()
            HStack (spacing: 40){
                //Buttons
                //Button home
                Button {
                      dismiss()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.radialGradient(colors: win ? [.rpsOrangeGradientBG, .rpsRedGradientBG] : [.rpsDarkBlueGradientBG, .rpsBlueGradientBG],
                                    center: .center, startRadius: 1, endRadius: 320))

    }
}

//#Preview {
//    EndGameView(avatarImageName: "avatarTest", scorePlayer1: 1, scorePlayer2: 3)
//}

