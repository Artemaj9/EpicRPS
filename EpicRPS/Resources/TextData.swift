//
//  TextData.swift
//

import Foundation

/*
 только для примера, для компактности большие тексты желательно выносить из вью.
 */
enum RulesTxt {
    static let rule1 = "Игра проводится между игроком и комьютером."
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
