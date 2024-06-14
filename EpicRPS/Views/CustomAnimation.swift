//
//  CustomAnimation.swift
//

import SwiftUI

struct CustomAnimation: View {
    
    @EnvironmentObject var vm: GameViewModel
    private let total = 50
    
    var body: some View {
        ZStack {
            ForEach(0..<total, id: \.self) { index in
                let total: CGFloat = CGFloat(total)
                let progress = CGFloat(index) / total
                let maxX: CGFloat = (progress > 0.5) ? 250 : -250
                let maxY: CGFloat = (progress > 0.5) ? 250 : -250
                
                let randomX = calculateRandomX(progress: progress, maxX: maxX)
                let randomY = calculateRandomY(progress: progress, maxY: maxY)
                let extraRandomX: CGFloat = .random(in: -250...250)
                let extraRandomY: CGFloat = (progress < 0.5 ? .random(in: 0...70) : .random(in: -70...0))
                
                Image(systemName: "star.fill")
                    .foregroundStyle(.red)
                    .scaleEffect(calculateScaleEffect(vm.strokeTime))
                    .offset(x: (randomX + extraRandomX) * 0.8 * min(2, max(0, vm.strokeTime - 0.8)),
                            y: (randomY + extraRandomY) * 0.8 * min(2, max(0, vm.strokeTime - 0.8)))
                    .opacity(calculateOpacity(vm.strokeTime))
                    .animation(.easeInOut, value: vm.strokeTime)
            }
        }
    }
    
    private func calculateRandomX(progress: CGFloat, maxX: CGFloat) -> CGFloat {
        return (progress > 0.5 ? progress - 0.5 : progress) * maxX
    }
    
    private func calculateRandomY(progress: CGFloat, maxY: CGFloat) -> CGFloat {
        return ((progress > 0.5 ? progress - 0.5 : progress) * maxY) * CGFloat.random(in: -3...3) + 35
    }
    
    private func calculateScaleEffect(_ strokeTime: CGFloat) -> CGFloat {
        return max(strokeTime - 0.5, 0) == 0 ? 0.001 : 1
    }
    
    private func calculateOpacity(_ strokeTime: CGFloat) -> Double {
        return strokeTime == 0 || strokeTime > 1.4 ? 0 : min(1.4-strokeTime,1)
    }
}
