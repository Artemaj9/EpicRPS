//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = GameViewModel()

    var body: some View {
        ZStack {
            if vm.isSplash {
                SplashView()
                    .environmentObject(vm)
            } else {
                MainView()
                    .environmentObject(vm)
            }
        }
        .ignoresSafeArea()
        .runAfterAppear(delay: 4) {
            vm.isSplash = false
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameViewModel())
}
