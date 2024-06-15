//
//  Sounds.swift
//

import Foundation

enum Sounds: String {
    case ambient = "ambient"
    case uprising = "uprising"
    case dark = "dark"
    case tap = "tap"
    case crash = "crash"

    static let music: [Sounds] = [.ambient, .uprising, .dark]
}
