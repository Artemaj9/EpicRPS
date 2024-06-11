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
                    .transition(.move(edge: .trailing))
            } else {
                MainView()
                    .environmentObject(vm)
            }
        }
        .ignoresSafeArea()
        .runAfterAppear(delay: 3) {
            vm.isSplash = false
        }
//        .onAppear {
//            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
//                withAnimation {
//                    self.vm.isSplash = false
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}
