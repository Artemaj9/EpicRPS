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
                .font(.custom(.rubikMedium, size: 20)).bold()
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(.rpsOrange)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: Color.rpsOrange.opacity(0.3), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    SettingsButton()
}
