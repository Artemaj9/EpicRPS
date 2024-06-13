//
//  LeaderBoardCell.swift
//  EpicRPS
//
//  Created by Daria on 12.06.2024.
//

import SwiftUI

struct LeaderBoardCell: View {
    var placeInRankin: Int
    var avatar: String
    var name: String
    var result: Double
    var rate: Int
    
    var body: some View {
        if placeInRankin == 1 || placeInRankin == 2 || placeInRankin == 3  {
            TopCell(placeInRankin: placeInRankin, avatar: avatar, name: name, result: result, rate: rate)
        } else {
            DefaultCell(placeInRankin: placeInRankin, avatar: avatar, name: name, result: result, rate: rate)
        }
    }
}

struct LeaderBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardCell(placeInRankin: 3, avatar: "character2", name: "Tony Newman", result: 19.54, rate: 58)
    }
}

struct TopCell: View {
    var placeInRankin: Int
    var avatar: String
    var name: String
    var result: Double
    var rate: Int
    #warning("Заменить цвета на точечный индекс")
    var body: some View {
        ZStack(alignment: .leading) {
            getBackgroundColor(for: placeInRankin)
                .cornerRadius(20)
                .opacity(placeInRankin == 1 ? 0.44 : 1)
            HStack(spacing: 50) {
                HStack(alignment: .center, spacing: 18) {
                    Image(avatar)
                        .resizableToFit()
                        .frame(width: 37, height: 37)
                        .padding(.leading, 16)
                    Text(name)
                        .foregroundColor(getForegroundColor(for: placeInRankin))
                        .font(.custom(.rubikBold, size: 14))
                }
                HStack(alignment: .center, spacing: 20) {
                    Text(String(format: "%.3f", result))
                        .foregroundColor(Color("rpsTextForCell"))
                        .font(.custom(.rubikBold, size: 13))
                    Text("\(rate)%")
                        .foregroundColor(Color("rpsTextForCell"))
                        .font(.custom(.rubikMedium, size: 18))
                }
            }
            Image(getMedal(for: placeInRankin))
                .resizable()
                .frame(width: 19, height: 19)
                .position(x: 338, y: 32.5)
        }
        .frame(width: 339, height: 65)
    }
    
    private func getBackgroundColor(for place: Int) -> Color {
        switch place {
        case 1:
            return Color("rpsFirstForCell")
        case 2:
            return Color("rpsSecondForCell")
        case 3:
            return Color("rpsThirdForCell")
        default:
            return Color.clear
        }
    }
    
    private func getForegroundColor(for place: Int) -> Color {
        switch place {
        case 1:
            return Color("rpsFirstTextForCell")
        case 2:
            return Color("rpsSecondTextForCell")
        case 3:
            return Color("rpsThirdTextForCell")
        default:
            return Color.clear
        }
    }
    
    private func getMedal(for place: Int) -> String {
        switch place {
        case 1:
            return MedalCellImage.goldMedal
        case 2:
            return MedalCellImage.silverMedal
        case 3:
            return MedalCellImage.bronzeMedal
        default:
            return ""
        }
    }
}


struct DefaultCell: View {
    var placeInRankin: Int
    var avatar: String
    var name: String
    var result: Double
    var rate: Int
    
    #warning("Заменить цвета на точечный индекс")
    var body: some View {
        HStack(spacing: 50) {
            HStack(alignment: .center, spacing: 18) {
                Text("\(placeInRankin)")
                    .foregroundColor(Color("rpsDefaultTextForCell"))
                    .font(.custom(.rubikBold, size: 9))
                Image(avatar)
                    .resizableToFit()
                    .frame(width: 37, height: 37)
                Text(name)
                    .foregroundColor(Color("rpsDefaultTextForCell"))
                    .font(.custom(.rubikBold, size: 14))
            }
            HStack(alignment: .center, spacing: 20) {
                Text(String(format: "%.3f", result))
                    .foregroundColor(Color("rpsDefaultTextForCell"))
                    .font(.custom(.rubikBold, size: 13))
                Text("\(rate)%")
                    .foregroundColor(Color("rpsDefaultTextForCell"))
                    .font(.custom(.rubikMedium, size: 18))
            }
        }
    }
}
