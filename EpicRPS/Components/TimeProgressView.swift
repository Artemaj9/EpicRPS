//
//  TimeProgress.swift
//
//  Я сделал адаптивный элемент который будет встраиваться в интерфейс
import SwiftUI

struct TimeProgress: View {
    @State var timeProgress: Double
    @State var gameTime: Int
    private var logicValueTimeLeft : Int {
        Int(Double(gameTime) * (1.0 - timeProgress))
    }
    var body: some View {
        GeometryReader { geo in
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.rpsScaleBG)
                    VStack{
                        if timeProgress != 0 { Spacer() }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.rpsScaleGreen)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray.opacity(timeProgress))
                        }
                        
                        .frame(height: (geo.size.height / CGFloat(gameTime)) * CGFloat(logicValueTimeLeft)  )
                    }
                    .frame(height: geo.size.height)
                }
                .frame(width: 10)
                Text(String(format: "%2d:%02d", logicValueTimeLeft / 60, logicValueTimeLeft % 60))
                    .font(.custom(RPSFont.rubikRegular, size: 14))
                    .padding(4)
            }
            .animation(.easeInOut(duration: 0.1), value: logicValueTimeLeft)
        }
    }
}

#Preview {
    TimeProgress(timeProgress: 0.5, gameTime: 30)
}
