//
//  NavigationHeader.swift
//  EpicRPS
//
//  Created by Руслан on 11.06.2024.
//

import SwiftUI

struct NavigationHeader: View {
    var title: String
    var isRound: Bool = false
    var isPaused: Binding<Bool>?
    var rightButtonAction: (() -> Void)?
    var leftButtonAction: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack{
            Button {
                leftButtonAction?()
                dismiss()
            } label: {
                Image(systemName: "control")
                    .resizableToFit()
                    .frame(width: 25)
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(isRound ? .white : .rpsGray)
            }
            .frame(width: 25)
            Spacer()
            Text(title)
                .font(.custom(RPSFont.rubikRegular, size: 25))
                .foregroundStyle(isRound ? .white : .rpsGray)
            Spacer()
            Button {
                rightButtonAction?()
            } label: {
                Image(systemName: !(isPaused?.wrappedValue ?? false) ? "pause.circle" : "play.circle")
                    .resizableToFit()
                    .frame(width: 25)
                    .foregroundStyle(.white)
                    .opacity(isRound ? 1 : 0)

            }
            .opacity(isRound ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal, 10)
    }
    func pauseToggle() {
        isPaused?.wrappedValue.toggle()
    }
}

#Preview {
    NavigationHeader(title: "Игра",isRound: false, isPaused: .constant(true)) {
        print("LeftButton")
    }

}
