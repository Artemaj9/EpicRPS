//
//  ScaleView.swift
//

import SwiftUI

struct ScaleView: View {
  @EnvironmentObject var vm: GameViewModel
  var height: CGFloat

  var body: some View {
    ZStack {
      ZStack {
        Rectangle()
          .foregroundStyle(.rpsScaleBG)

        VStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(.rpsColorPlayer2)
            .frame(height: CGFloat(vm.player2Score) * (height / 6))

          Spacer()
        }

        VStack(alignment: .leading) {
          Spacer()

          RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(.rpsColorPlayer1)
            .frame(height: CGFloat(vm.player1Score) * (height / 6))
        }

        Rectangle()
          .frame(height: 2)
          .foregroundStyle(.white)
      }
      .frame(maxWidth: 10)

      VStack {
        Image(vm.currentPlayer2.avatar)
          .resizableToFit()
          .offset(y: -25)
          .rotationEffect(.degrees(Double(vm.player2Score) * 360), anchor: .top)
        Spacer()
      }

      VStack {
        Spacer()

        Image(vm.currentPlayer1.avatar)
          .resizableToFit()
          .offset(y: 25)
          .rotationEffect(.degrees(Double(vm.player1Score) * 360), anchor: .bottom)
      }
    }
    .animation(.bouncy(duration: 1, extraBounce: 0.1), value: vm.player1Score)
    .animation(.bouncy(duration: 1, extraBounce: 0.1), value: vm.player2Score)
    .frame(width: 42, height: height)
  }
}

#Preview {
  ScaleView(height: 200)
    .environmentObject(GameViewModel())
}
