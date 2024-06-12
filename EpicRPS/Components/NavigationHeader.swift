//
//  NavigationHeader.swift
//  EpicRPS
//
//  Created by Руслан on 11.06.2024.
//

import SwiftUI

struct NavigationHeader: View {
    @State var title: String
    @State var isRound: Bool
    @State var isPaused: Bool
    var leftButtonAction: () -> ()
    var rightButtonAction: () -> ()

    var body: some View {
        HStack{
            Button{
                leftButtonAction()
            } label: {
                Image(systemName: "control")
                    .resizableToFit()
                    .frame(width: 25)
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(.gray)
            }
            .frame(width: 25)
            Spacer()
            Text(title)
                .font(.custom(RPSFont.rubikRegular, size: 25))
                .foregroundStyle(.gray)
            Spacer()
            Button{
                rightButtonAction()
                isPaused.toggle()
            } label: {
                Image(systemName: !isPaused ? "pause.circle" : "play.circle")
                    .resizableToFit()
                    .frame(width: 25)
                    .foregroundStyle(.gray)
                    .opacity(isRound ? 1 : 0)
            }       
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal, 10)
    }
    func pauseToggle() {
        isPaused.toggle()
    }
}

#Preview {
    NavigationHeader(title: "Игра", isRound: true, isPaused: true) {
        print("LeftButton")
    } rightButtonAction: {
        print("RightButton")
    }

}
