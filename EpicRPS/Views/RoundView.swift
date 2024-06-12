//
//  RoundView.swift
//
//  Created by Evgeniy K on 10.06.2024.
//

import SwiftUI

struct RoundView: View {

    var femaleArm = FemaleArms.femalePaper
    var maleArm = MaleArms.maleRock
    var roundText = RoundTextStatus.win
    var textIsShowing = true
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        ZStack {
            VStack {
                // Верхняя картинка руки: female
                Text("\(vm.time)")
                Image(femaleArm)
                    .resizableToFit()
                
                // Текст, состояние игры
                if textIsShowing {
                    Text(roundText)
                    //.font(.custom(.rubicMedium, size: 56))
                        .font(.system(size: 56, weight: .bold))
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                }
                
                // Нижняя картинка руки: male
                Image(maleArm)
                    .resizableToFit()
            }
            
            HStack {
                TimeProgress()
                    .frame(height: vm.size.height/4)
                    .padding(10)
                    .environmentObject(vm)

                Spacer()

                ScaleView(height: vm.size.height/3)
                    .environmentObject(vm)
                    .padding(10)
            }
        }
        .onAppear {
            vm.setupTimer()
        }
    }
}

#Preview {
    RoundView(femaleArm: FemaleArms.femaleO, maleArm: MaleArms.maleO, roundText: RoundTextStatus.fight, textIsShowing: true)
        .environmentObject(GameViewModel())
}
