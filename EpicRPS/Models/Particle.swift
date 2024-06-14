//
//  Particle.swift
//


import Foundation

struct Particle: Identifiable {
    var id = UUID()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    var opacity: CGFloat = 1
    
    mutating func reset() {
        randomX = 0
        randomY = 0
        scale = 0
        opacity = 1
    }
}
