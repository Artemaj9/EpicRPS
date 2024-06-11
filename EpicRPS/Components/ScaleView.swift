//
//  ScaleView.swift
//  EpicRPS
//
//  Created by Руслан on 10.06.2024.
//

import SwiftUI

struct ScaleView: View {
    @State var player1Points: Int
    @State var player2Points: Int
    var frameHeight: CGFloat
    var firstUserImage: String
    var secondUserImage: String
    var body: some View {
        
        ZStack {
            ZStack{
                Rectangle()
                    .foregroundStyle(.rpsScaleBG)
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.rpsColorPlayer2)
                        .frame(height: CGFloat(player2Points) * (frameHeight / 6))
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Spacer()
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.rpsColorPlayer1)
                        .frame(height: CGFloat(player1Points) * (frameHeight / 6))
                    
                }
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }.frame(maxWidth: 10)
            VStack{
                Image(secondUserImage)
                    .resizableToFit()
                    .offset(y: -25)
                    .rotationEffect(.degrees(Double(player2Points) * 360), anchor: .top)
                Spacer()
            }
            VStack{
                Spacer()
                Image(firstUserImage)
                    .resizableToFit()
                    .offset(y: 25)
                    .rotationEffect(.degrees(Double(player1Points) * 360), anchor: .bottom)
            }
        }

        .animation(.bouncy(duration: 1, extraBounce: 0.1), value: player1Points)
        .animation(.bouncy(duration: 1, extraBounce: 0.1), value: player2Points)
        .frame(width: 42, height: frameHeight)
    }
    init(player1Points: Int, player2Points: Int, firstUserImage: String = "avatarTest", secondUserImage: String = "avatarTest") {
        self.player1Points = player1Points
        self.player2Points = player2Points
        self.firstUserImage = firstUserImage
        self.secondUserImage = secondUserImage
        self.frameHeight = 300
    }
    
    init(player1Points: Int, player2Points: Int, firstUserImage: String = "avatarTest", secondUserImage: String = "avatarTest", height: CGFloat) {
        self.player1Points = player1Points
        self.player2Points = player2Points
        self.firstUserImage = firstUserImage
        self.secondUserImage = secondUserImage
        self.frameHeight = height
    }
}

#Preview {
    ScaleView(player1Points: 1, player2Points: 2, firstUserImage: "avatarTest", secondUserImage: "avatarTest")
}
