import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    @AppStorage("gameTime") var gameTime: Double = 10
    @AppStorage("backgroundMusic") var backGroundMusic = Sounds.ambient.rawValue
    @AppStorage("multiplayer") var multiplayer = false

    @Published var size = CGSize(width: 430, height: 932)
    @Published var isSplash = true
    @Published var time: Double = 0
    @Published var isPaused = false
    @Published var player1Score = 0
    @Published var player2Score = 0
    @Published var player1Selection = Selection.notSelect
    @Published var player2Selection = Selection.notSelect
    @Published var gamePhase: GameState = .loading
    @Published var winner = 0
    @Published var femaleArm: String = FemaleArms.femaleO
    @Published var maleArm: String = MaleArms.maleO
    @Published var isDraw = false
    @Published var secondPlayerTurn = false
    @Published var currentPlayer1: Player = UserDefaultsService.shared.get(forKey: "currentPlayer1") ?? Player(name: "Player1", avatar: "avatarTest")
    @Published var currentPlayer2: Player = UserDefaultsService.shared.get(forKey: "currentPlayer2") ?? Player(name: "Computer", avatar: "avatarTest")
    @Published var allPlayers: [Player] = []

    var cancellables = Set<AnyCancellable>()

    func startRound() {
        if !multiplayer {
            player2Selection = Selection.random()
        }
        setupTimer()
    }

    func startArmAnimation() {
        updateArms()
        isDraw = player1Selection == player2Selection
        performAction(after: 2) {
            self.resetTimer()
        }
    }

    func setupTimer() {
        if !multiplayer {
            player2Selection = Selection.random()
        }
        isPaused = false
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    time += 0.1
                }
                if time >= gameTime {
                    resetTimer()
                }
            }
            .store(in: &cancellables)
    }

    private func resetTimer() {
        time = 0
        cancellables.forEach { $0.cancel() }
        checkWinner()
    }

    private func checkWinner() {
        if player1Selection.rawValue == -1 || player2Selection.rawValue == -1 {
            winner = player1Selection.rawValue == -1 ? 2 : 1
        } else {
            winner = (3 + player2Selection.rawValue - player1Selection.rawValue) % 3
            // + здесь может быть любое полож число делящееся на 3, чтобы перевести выражение в положительную область
            // остатки в swift могут быть отрицательные (не так как в матем)
        }
        updateScores()
        if max(player1Score, player2Score) == 3 {
            endGame()
        } else {
            resetSelections()
            setupTimer()
        }
    }

    private func updateScores() {
        switch winner {
        case 1:
            player1Score += 1
        case 2:
            player2Score += 1
        default:
            performAction(after: 0.4) {
                self.isDraw = false
            }
        }
    }

    private func endGame() {
        performAction(after: 1.5) {
            withAnimation(.easeIn(duration: 0.7)) {
                self.gamePhase = .end
            }
        }
        updatePlayerStats()
        savePlayerStats()
    }

    private func resetSelections() {
        player1Selection = .notSelect
        player2Selection = .notSelect
        maleArm = MaleArms.maleO
        femaleArm = FemaleArms.femaleO
        winner = 0
        secondPlayerTurn = false
    }

    private func updatePlayerStats() {
        currentPlayer1.games += 1
        currentPlayer2.games += 1
        if winner == 1 {
            currentPlayer1.wins += 1
        } else {
            currentPlayer2.wins += 1
        }
    }

    private func savePlayerStats() {
        UserDefaultsService.shared.save(structs: currentPlayer1, forKey: "currentPlayer1")
        UserDefaultsService.shared.save(structs: currentPlayer2, forKey: "currentPlayer2")
        updateAllPlayersList()
        UserDefaultsService.shared.save(structs: allPlayers, forKey: "allPlayers")
    }

    private func updateAllPlayersList() {
        updatePlayerInList(currentPlayer1)
        updatePlayerInList(currentPlayer2)
    }

    private func updatePlayerInList(_ player: Player) {
        if let index = allPlayers.firstIndex(of: player) {
            allPlayers[index] = player
        } else {
            allPlayers.append(player)
        }
    }

    func resetGame() {
        cancellables.forEach { $0.cancel() }
        time = 0
        isPaused = false
        isDraw = false
        resetSelections()
        player1Score = 0
        player2Score = 0
        winner = 0
        secondPlayerTurn = false
    }

    private func updateArms() {
        if !multiplayer {
            maleArm = maleArms[player1Selection.rawValue]
            femaleArm = femaleArms[player2Selection.rawValue]
        } else {
            maleArm = maleArms[player1Selection.rawValue]
            femaleArm = femaleArms[player2Selection.rawValue]
        }
    }
}

private let femaleArms = [FemaleArms.femaleRock, FemaleArms.femaleScissors, FemaleArms.femalePaper]
private let maleArms = [MaleArms.maleRock, MaleArms.maleScissors, MaleArms.malePaper]
