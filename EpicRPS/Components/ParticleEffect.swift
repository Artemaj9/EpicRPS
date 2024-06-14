//
//  ParticleEffect.swift
//

import SwiftUI

extension View {
    @ViewBuilder
    func particleEffect(
        systemImage: String,
        font: Font,
        status: Bool,
        color: Color
    ) -> some View {
        self
            .modifier(
                ParticleModifier(
                    systemImage: systemImage,
                    font: font,
                    status: status,
                    color: color
                )
            )
    }
}

fileprivate struct ParticleModifier: ViewModifier {
    var systemImage: String
    var font: Font
    var status: Bool
    var color: Color
    
    @State private var particles: [Particle] = []
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            ZStack {
                ForEach(particles) {
                    particle in
                    Image(systemName: systemImage)
                        .foregroundStyle(color)
                        .scaleEffect(particle.scale)
                        .offset(x: particle.randomX, y: particle.randomY)
                        .opacity(particle.opacity)
                        .opacity(status ? 1 : 0)
                        .animation(.none, value: status)
                        .blur(radius: 3)
                        .saturation(Double.random(in: 0.5...2))
                }
            }
            .onAppear {
                if particles.isEmpty {
                    for _ in 1...100 {
                        let particle = Particle()
                        particles.append(particle)
                    }
                }
            }
            .onChange(of: status) {  newValue in
                if !newValue {
                    for index in particles.indices {
                        particles[index].reset()
                    }
                } else {
                    for index in particles.indices {
                        let total: CGFloat = CGFloat(particles.count)
                        let progress: CGFloat = CGFloat(index) / total
                        let maxX: CGFloat = (progress > 0.5) ? 100 : -100
                        let maxY: CGFloat = (progress > 0.5) ? 120 : -120
                        
                        let randomX: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress)*maxX)
                        let randomY: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxY)*CGFloat.random(in: -3...3) + 35
                        let randomScale: CGFloat = .random(in: 0.35...1)
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7)) {
                            let extraRandomX: CGFloat = .random(in: -50...50)
                            let extraRandomY: CGFloat = (progress < 0.5 ? .random(in: 0...200) : .random(in: -200...0))
                            particles[index].randomX = randomX + extraRandomX
                            particles[index].randomY = randomY + extraRandomY
                        }
                        
                        withAnimation(.easeInOut(duration: 0.7)) {
                            particles[index].scale = randomScale
                        }
                        
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7).delay((Double(index) * 0.0001))){
                            particles[index].scale = 0.001
                        }
                        
                    }
                }
            }
        }
    }
}
