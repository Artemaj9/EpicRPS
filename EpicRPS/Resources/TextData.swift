//
//  TextData.swift
//

import Foundation
enum RulesTxt {
    static let rule = "Rules"
    static let rule1 = "Игра проводится между игроком и комьютером."
    static let rule2 = "Жесты:"
    static let rule21 = "Кулак > Ножницы"
    static let rule22 = "Бумага > Кулак"
    static let rule23 = "Ножницы > Бумага"
    static let rule3 = "У игрока есть 30 сек. для выбора жеста."
    static let rule4 = "Игра ведётся до трёх побед одного из участников."
}

// MARK: - arms pic names
enum FemaleArms {
    static let femaleO = "female-o"
    static let femalePaper = "female-paper"
    static let femaleRock = "female-rock"
    static let femaleScissorsHurt = "female-scissors-hurt"
    static let femaleScissors = "female-scissors"
}

enum MaleArms {
    static let maleO = "male-o"
    static let malePaper = "male-paper"
    static let maleRock = "male-rock"
    static let maleScissors = "male-scissors"
}

// MARK: - text variants for game status
enum RoundTextStatus {
    static let fight = "fight"
    static let lose = "lose"
    static let win = "win"
    static let draw = "draw"
}
