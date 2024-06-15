//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    @State private var opacity: CGFloat = 1
    @State private var saturation: CGFloat = 0
    @State private var textOpacity: CGFloat = 0
    @State private var offset: Double = 0
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
                .readSize($vm.size)

            MetalView()
                .scaleEffect(5)
                .offset(x: 1.5 * vm.size.width, y: -vm.size.height)
                .rotationEffect(.degrees(-50))
                .blur(radius: 70)
                .saturation(saturation)
                .animation(.easeIn(duration: animationDuration), value: saturation)
                .opacity(opacity)
                .animation(.easeIn(duration: fullAnimationDuration), value: saturation)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            opacity = 0
            saturation = 1
            textOpacity = 1
            if !vm.multiplayer {
                vm.currentPlayer2 =
                    vm.allPlayers.first(
                        where: { $0.name == "Computer" }
                    )
                    ?? Player(
                        name: "Computer",
                        avatar: "avatarTest"
                    )
            }
            vm.addCurrentPlayers()
        }
    }
}

private let animationDuration: Double = 0.7
private let fullAnimationDuration: Double = 5

#Preview {
    SplashView()
        .environmentObject(GameViewModel())
}
