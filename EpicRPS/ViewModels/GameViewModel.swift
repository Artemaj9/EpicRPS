//
//  GameViewModel.swift
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    @AppStorage("gameTime") var gameTime: Double = 10
    @AppStorage("backgroundMusic") var backGroundMusic = Sounds.bgPiano
    @AppStorage("playWithFriend") var playWithFriend = false

    @Published var size = CGSize(width: 430, height: 932) // размер экрана
    @Published var isSplash = true // показывается ли Splash screen?
    @Published var time: Double = 0 // сколько времени прошло с начала раунда
    @Published var isPaused  = false
    @Published var player1Score = 0
    @Published var player2Score = 0
    @Published var player1Selection = 0
    @Published var player2Selection = 0
    @Published var gamePhase: GameState = .loading
    @Published var winner = 0

    @Published var currentPlayer1: Player =
    UserDefaultsService.shared.get(
        forKey: "currentPlayer1"
    ) ?? Player(name: "Player1", avatar: "")
    
    @Published var currentPlayer2: Player =
    UserDefaultsService.shared.get(
        forKey: "currentPlayer2"
    ) ?? Player(name: "Computer", avatar: "")
    
    var cancellables = Set<AnyCancellable>()
    
    func setupTimer() {
        Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                time += 0.1
                if time >= gameTime {
                   
                        resetTimer()
                
                }
            }
            .store(in: &cancellables)
    }
    
    func resetTimer() {
        time = 0
        checkWinner()
        for item in cancellables {
            item.cancel()
        }
    }
    
    func checkWinner() {
        winner = (3 + player2Selection - player1Selection) % 3
        
        if winner == 1 {
            player1Score += 1
        } else if winner == 2 {
            player2Score += 1
        }
        
      //  if max(player1Score, player2Score) == 3 {
        withAnimation(.easeIn(duration: 0.4)) {
            gamePhase = .end
        }
       // }
    }
    
    func resetGame() {
        time = 0
        player1Score = 0
        player2Score = 0
        winner = 0
    }
}
