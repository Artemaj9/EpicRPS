//
//  SettingsButton.swift
//  EpicRPS
//
//  Created by Evgeniy K on 11.06.2024.
//

import SwiftUI

struct SettingsButton: View {
    
    var text = "30 сек."
    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Text(text)
                .font(.custom(.rubikMedium, size: 20)).bold()
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 20))
        }
    }
}

#Preview {
    SettingsButton(action: {})
}
