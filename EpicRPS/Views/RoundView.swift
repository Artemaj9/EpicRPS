//
//  RoundView.swift
//
//  Created by Evgeniy K on 10.06.2024.
//

import SwiftUI

struct RoundView: View {
   // var roundText = RoundTextStatus.win
   // var textIsShowing = true
    @EnvironmentObject var vm: GameViewModel

    var body: some View {
        ZStack {
            VStack {
                // Верхняя картинка руки: female
                Text("\(vm.time)")
                Image(vm.femaleArm)
                    .resizableToFit()
                   // .offset(y: -100cos(vm.armTime))
                 //   .animation(.easeIn, value: vm.armsOffset)
                
                // Текст, состояние игры
               // if vm.isDraw {
                    Text("DRAW")
                    .font(.custom(.rubikMedium, size: 56))
                    .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundStyle(.rpsOrange)
                        .padding()
                        .opacity(vm.isDraw ? 1 : 0)
                        .animation(.easeIn, value: vm.isDraw)
               // }
                
                // Нижняя картинка руки: male
                Image(vm.maleArm)
                    .resizableToFit()
                  //  .offset(y: vm.armsOffset)
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
        .overlay(alignment: .bottom) {
            GameButtons()
        }
        .onAppear {
            vm.setupTimer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoundView()
        .environmentObject(GameViewModel())
}
