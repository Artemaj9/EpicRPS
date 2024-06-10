//
//  RoundView.swift
//
//  Created by Evgeniy K on 10.06.2024.
//

import SwiftUI

struct RoundView: View {

    var femaleArm: String
    var maleArm: String
    var roundText: String
    var textIsShowing: Bool

    var body: some View {

        VStack {
            // Верхняя картинка руки: female
            Image(femaleArm)
                .resizableToFit()

            // Текст, состояние игры
            if textIsShowing {
                Text(roundText)
                //.font(.custom(.rubicMedium, size: 56))
                    .font(.system(size: 56, weight: .bold))
                    .textCase(.uppercase)
                    .foregroundStyle(.rpsOrange)
                    .padding()
            }
            // Нижняя картинка руки: male
            Image(maleArm)
                .resizableToFit()
        }
    }
}

#Preview {
    RoundView(femaleArm: FemaleArms.femaleO, maleArm: MaleArms.maleO, roundText: RoundTextStatus.fight, textIsShowing: true)
}
