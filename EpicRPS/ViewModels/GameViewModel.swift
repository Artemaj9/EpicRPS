//
//  GameViewModel.swift
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    @AppStorage("gameTime") var gameTime: Double = 30
}
