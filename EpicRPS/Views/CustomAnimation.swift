//
//  CustomAnimation.swift
//

import SwiftUI

struct CustomAnimation: View {
    
    @EnvironmentObject var vm: GameViewModel
    
    var body: some View {
        ZStack {
            ForEach(0..<100, id: \.self) { index in
                let total: CGFloat = 100
                let progress = CGFloat(index) / total
                let maxX: CGFloat = (progress > 0.5) ? 250 : -250
                let maxY: CGFloat = (progress > 0.5) ? 150 : -150
                
                let randomX = calculateRandomX(progress: progress, maxX: maxX)
                let randomY = calculateRandomY(progress: progress, maxY: maxY)
                let extraRandomX: CGFloat = .random(in: -250...250)
                let extraRandomY: CGFloat = (progress < 0.5 ? .random(in: 0...70) : .random(in: -70...0))
                
                Image(systemName: "star.fill")
                    .foregroundStyle(.red)
                    .scaleEffect(calculateScaleEffect(vm.strokeTime))
                    .offset(x: (randomX + extraRandomX) * 0.8 * min(2, max(0, vm.strokeTime - 0.5)),
                            y: (randomY + extraRandomY) * 0.8 * min(2, max(0, vm.strokeTime - 0.5)))
                    .opacity(calculateOpacity(vm.strokeTime))
                    .saturation(Double.random(in: 0.5...2))
                    .animation(.linear, value: vm.strokeTime)
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
        return max(strokeTime - 0.5, 0) == 0 ? 0.001 : 0.3
    }
    
    private func calculateOpacity(_ strokeTime: CGFloat) -> Double {
        return strokeTime == 0 || strokeTime > 1.4 ? 0 : 1
    }
}
