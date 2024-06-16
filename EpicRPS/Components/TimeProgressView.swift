//
//  TimeProgress.swift
//

import SwiftUI

struct TimeProgress: View {
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.rpsScaleBG)

                    VStack {
                        if vm.time != 0 { Spacer() }

                        ZStack {

                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.rpsScaleGreen)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray.opacity(vm.time / vm.gameTime))
                        }
                        .frame(
                            height: (geo.size.height / CGFloat(vm.gameTime))
                                * CGFloat(vm.gameTime - vm.time))
                    }
                    .frame(height: geo.size.height)
                }
                .frame(width: 10)

                Text(
                    String(
                        format: "%2d:%02d", Int((vm.gameTime - vm.time).rounded()) / 60,
                        Int((vm.gameTime - vm.time).rounded()) % 60)
                )
                .font(.custom(RPSFont.rubikRegular, size: 14))
                .foregroundStyle(.white)
                .padding(4)
                .frame(width: 50, alignment: .center)
            }
            .animation(.linear(duration: 0.1), value: vm.time)
        }
    }
}

#Preview {
    TimeProgress()
        .environmentObject(GameViewModel())
}
