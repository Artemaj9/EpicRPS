//
//  SettingsView.swift
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {

        VStack {
            Text("врямя игры")
                .font(.custom(.rubikRegular, size: 30))
                .textCase(.uppercase)
                .padding()
            HStack {
                SettingsButton(text: "30 сек.") {
                    // action to select
                }
                Spacer()
                SettingsButton(text: "60 сек.") {
                    // action to select
                }
            }
            .padding()
        }

        VStack {

        }

        Spacer()
        
    }
}

#Preview {
    SettingsView()
}
