//
//  GameView.swift
//

import SwiftUI

struct GameView: View {
    var body: some View {
        RoundView(
            femaleArm: FemaleArms.femalePaper,
            maleArm: MaleArms.maleRock,
            roundText: RoundTextStatus.win,
            textIsShowing: true
        )
    }
}

#Preview {
    GameView()
}
