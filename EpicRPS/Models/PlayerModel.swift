//
//  PlayerModel.swift
//

import Foundation

struct Player: Codable {
    var name: String
    var games: Int = 0
    var wins: Int = 0
    var avatar: String
}
