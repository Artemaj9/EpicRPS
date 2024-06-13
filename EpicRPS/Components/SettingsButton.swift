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
                .shadow(radius: 3)
                .padding(13)
                .frame(width: 145)
                .background(.rpsPeachSettings)
                .clipShape(.rect(cornerRadius: 18))
        }
    }
}

#Preview {
    SettingsButton(action: {})
}
