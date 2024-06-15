//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    @State private var firstAnim = false
    @State private var secondAnim = false
    @State private var thirdAnim = false
    @State private var fourthAnim = false
    @State private var fifthAnim = false
    @State private var opacity: Double = 0
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.rpsLightGray)
                    .ignoresSafeArea()
                VStack {
                    topButtons
                        .padding(18)
                        .opacity(opacity)
                        .animation(.smooth(duration: 1).delay(1.5), value: opacity)

                    Spacer()

                    epicRPSView
                        .frame(maxWidth: .infinity, maxHeight: 310)
                        .padding(.vertical, 30)

                    menuButtons
                        .frame(maxWidth: 200, maxHeight: 200)
                        .opacity(opacity)
                        .animation(.easeIn(duration: 0.5).delay(1), value: opacity)
                }
                .onAppear {
                    vm.gamePhase = .loading
                    firstAnim = true
                    opacity = 1
                    vm.resetGame()
                    if let player = SoundService.player.avPlayer {
                        player.stop()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                        secondAnim = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        fifthAnim = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        thirdAnim = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        fourthAnim = true
                    }

                }
                .animation(.bouncy(duration: 1, extraBounce: 0.3), value: firstAnim)
                .animation(.easeOut(duration: 1).delay(0.05), value: secondAnim)
                .animation(.easeInOut(duration: 0.5).repeatForever(), value: thirdAnim)
                .animation(.easeInOut(duration: 0.8).repeatForever(), value: fourthAnim)
                .animation(.easeInOut(duration: 0.8).repeatForever(), value: fifthAnim)
            }
        }
        .navigationViewStyle(.stack)
        .frame(width: vm.size.width, height: vm.size.height)
    }

    private var topButtons: some View {
        HStack {
            settingsButton
            Spacer()
            helpButton
        }
    }

    private var settingsButton: some View {
        Button {
        } label: {
            NavigationLink(destination: SettingsView()) {
                Image("settings-icon")
            }
        }
    }

    private var helpButton: some View {
        Button {
        } label: {
            NavigationLink(destination: RulesView()) {
                Image("help-icon")
            }
        }
    }

    private var epicRPSView: some View {
        VStack {
            HStack {
                Spacer()
                Image("male-rock-cut")
                    .resizableToFit()
                    .offset(x: secondAnim ? 0 : 200)
                    .scaleEffect(secondAnim ? 1.2 : 0.8)
                    .offset(x: thirdAnim ? 10 : 0)
                    .scaleEffect(thirdAnim ? 1.05 : 1)
                    .rotationEffect(.degrees(thirdAnim ? 10 : 0), anchor: .trailing)
            }
            ZStack {
                Text("EPIC RPS")
                    .font(Font.custom(.rubikBold, size: 30))
                    .foregroundStyle(.rpsLightPeach)
                    .shadow(color: .rpsDarkPeach, radius: 0, x: 2, y: 2)
                    .padding(.vertical, 50)
                    .scaleEffect(firstAnim ? 1 : 0)
                    .scaleEffect(fifthAnim ? 1.1 : 1.4)
                    .hueRotation(Angle(degrees: fifthAnim ? -10 : 0))
            }
            HStack {
                Image("female-scissors-cut")
                    .resizableToFit()
                    .offset(x: secondAnim ? 0 : -200)
                    .scaleEffect(secondAnim ? 1.2 : 0.8)
                    .rotationEffect(.degrees(fourthAnim ? 7 : 0), anchor: .leading)
                Spacer()
            }
        }
    }

    private var menuButtons: some View {
        VStack(spacing: 20) {
            startButton
            resultButton
        }
    }

    private var startButton: some View {
        Button {
            vm.gamePhase = .loading
        } label: {
            NavigationLink(destination: GameView().environmentObject(vm)) {
                menuButtonStyle(text: "START")
            }
        }
    }

    private var resultButton: some View {
        Button {
        } label: {
            NavigationLink(destination: LeaderBoardView()) {
                menuButtonStyle(text: "RESULT")
            }
        }
    }

    private func menuButtonStyle(text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.rpsDarkPeach)
                .shadow(color: .rpsShadowPeach, radius: 0, y: 6)
            HStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.rpsLightPeach)
                Spacer(minLength: 100)
            }
            Text(text)
                .font(.custom("Rubik-Bold", fixedSize: 16))
                .foregroundStyle(.rpsPeachText)
        }
        .frame(maxHeight: 54)
    }

    func animReset() {
        firstAnim = false
        secondAnim = false
    }
}

#Preview {
    MainView()
        .environmentObject(GameViewModel())
}
