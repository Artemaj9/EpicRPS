//
//  RulesView.swift
//

import SwiftUI

struct RulesView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            NavigationHeader(title: "Rules")
                .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 16) {
                
                RulesStyle(number: "1", textRule: Text(RulesTxt.rule1))
                RulesStyle(number: "2", textRule: Text(RulesTxt.rule2))
                
                VStack(alignment: .leading) {
                    RulesExtraStyle(gesture: RulesImage.stone, textRule: RulesTxt.rule21)
                    RulesExtraStyle(gesture: RulesImage.paper, textRule: RulesTxt.rule22)
                    RulesExtraStyle(gesture: RulesImage.scissors, textRule: RulesTxt.rule23)
                }
                
                RulesStyle(number: "3", textRule: Text(RulesTxt.rule3))
                RulesStyle(number: "4", textRule: Text(RulesTxt.rule4))
                RulesStyle(number: "5", textRule: customRule5Text())
                Spacer()
                Spacer()
            }
            .padding(.leading, 27)
            .padding(.top, 23)
        }
        .navigationBarHidden(true)
        .gesture(
            DragGesture(minimumDistance: 5.0, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width > 50 && abs(value.translation.height) < 50 {
                     dismiss()
                    }
                }
        )

    }
    
    private func customRule5Text() -> Text {
        let part1 = Text("За каждую победу игрок получает ")

        let highlighted = Text("500 баллов,").foregroundColor(.rpsDarkVioletText)
        
        let part2 = Text(" которые можно посмотреть на доске лидеров.")
        
        return part1 + highlighted + part2
    }
}


struct RulesStyle: View {
    var number: String
    var textRule: Text
    var body: some View {
        HStack {
            ZStack {
                Image(RulesImage.yellowCircle)
                    .frame(width: 29,height: 29)
                
                Text(number)
                    .font(.custom(.delaGothicOneRegular, size: 16))
                    .offset(x: 0, y: -3)
            }
            textRule
                .font(.custom(.rubikRegular, size: 16))
        }
        .shadow( radius: 4, x: 0, y: 4)
    }
}

#Preview {
    RulesView()
}

struct RulesExtraStyle: View {
    var gesture: String
    var textRule: String
    var body: some View {
        HStack {
            Image(gesture)
                .frame(width: 30,height: 30)
                .padding(.leading, 66)
            Text(textRule)
                .shadow( radius: 4, x: 0, y: 4)
        }
    }
}

