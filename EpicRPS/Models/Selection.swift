//
//  Selection.swift
//

import Foundation

enum Selection: Int {
    case notSelect = -1
    case rock
    case scissors
    case papper
}

extension Selection {
    static func random() -> Selection {
        let selections: [Selection] = [.rock,.scissors,.papper]
        let randomIndex = Int(arc4random()) % selections.count
        return selections[randomIndex]
    }
}
