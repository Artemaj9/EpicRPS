//
//  RulesView.swift
//

import SwiftUI

struct RulesView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                //Spacer()
                RulesStyle(number: "1", textRule: Text(RulesTxt.rule1))
                RulesStyle(number: "2", textRule: Text(RulesTxt.rule2))
                
                VStack(alignment: .leading) {
                    RulesExtraStyle(gesture: RulesImage.stone, textRule: RulesTxt.rule2_1)
                    RulesExtraStyle(gesture: RulesImage.paper, textRule: RulesTxt.rule2_2)
                    RulesExtraStyle(gesture: RulesImage.scissors, textRule: RulesTxt.rule2_3)
                }
                
                RulesStyle(number: "3", textRule: Text(RulesTxt.rule3))
                RulesStyle(number: "4", textRule: Text(RulesTxt.rule4))
                RulesStyle(number: "5", textRule: customRule5Text())
                Spacer()
                Spacer()
            }
            .padding(.leading, 27)
            .padding(.top, 23)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("Arrow")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Rules")
                        .font(.custom(.rubikRegular, size: 25))
                }
            }
        }
    }
    
    private func customRule5Text() -> Text {
        let part1 = Text("За каждую победу игрок получает ")
        
        #warning("Tут нужно использовать точечный модификатор цвета для foregroundColor")
        let highlighted = Text("500 баллов,").foregroundColor(Color("rpsPurple"))
        
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
            }
            textRule
                .font(.custom(.rubikRegular, size: 16))
        }
        .shadow( radius: 4, x: 0, y: 4)
    }
}

#Preview {
    RulesView()
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
