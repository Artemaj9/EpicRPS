//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject var vm: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Winner: \(vm.winner)")
            Button {
                vm.gamePhase = .round
                
            } label: {
                Text("Restart game!")
            }
            
            Button {
                dismiss()
            } label: {
                Text("Go home")
            }
        }
    }
}

#Preview {
    EndGameView()
        .environmentObject(GameViewModel())
}
