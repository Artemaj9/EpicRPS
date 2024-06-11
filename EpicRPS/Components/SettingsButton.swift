//
//  SettingsButton.swift
//  EpicRPS
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsButton: View {

    var text = "30 сек."
    var action = {}

    var body: some View {

        Button {

        } label: {
            Text(text)
                .font(.custom(.rubikMedium, size: 25)).bold()
                .foregroundStyle(.white)
                .shadow(radius: 10)
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.rpsOrange)
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: Color.rpsOrange.opacity(0.3), radius: 20, x: 0, y: 10)
        }
    }
}

#Preview {
    SettingsButton()
}
