//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    @State var opacity: CGFloat = 1
    @State var blur: CGFloat = 0
    @State var saturation: CGFloat = 0
    @State var textOpacity: CGFloat = 0
    @State var offset: Double = 0
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
                .readSize($vm.size)
        
            MetalView()
                .scaleEffect(5)
                .offset(x: 1.5*vm.size.width, y: -vm.size.height)
                .rotationEffect(.degrees(-50))
                .blur(radius: 70)
                .saturation(saturation)
                .animation(.easeIn(duration: 0.7), value: saturation)
                .opacity(opacity)
                .animation(.easeIn(duration: 5), value: saturation)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            blur = 0
            opacity = 0
            saturation = 1
            textOpacity = 1
            
//           Clean up and reset UserDefaults
//            UserDefaultsService.shared.removeData(forKey: "allPlayers")
//            vm.allPlayers = UserDefaultsService.shared.get(forKey: "allPlayers") ?? [Player(name: "Computer", avatar: "avatarTest"), Player(name: "Player1", avatar: "character2")]
//            print(vm.allPlayers.count)
//            UserDefaultsService.shared.removeData(forKey: "currentPlayer1")
//            UserDefaultsService.shared.removeData(forKey: "currentPlayer2")
//            vm.currentPlayer1 = Player(name: "Player1", avatar: "character2")

            if !vm.multiplayer {
                vm.currentPlayer2 = vm.allPlayers.first(where: {$0.name == "Computer"}) ?? Player(name: "Computer", avatar: "avatarTest")
            }
            vm.addCurrentPlayers()
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(GameViewModel())
}

extension View {
    func invertMask<Mask: View>(_ mask: Mask) -> some View {
        self
            .mask(
                mask
                    .blendMode(.destinationOut)
                    .background(Color.black)
            )
    }
}
