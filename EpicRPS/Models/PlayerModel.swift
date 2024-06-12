//
//  PlayerModel.swift
//

import Foundation

struct Player: Codable, Equatable {
    var name: String
    var games: Int = 0
    var wins: Int = 0
    var avatar: String
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
