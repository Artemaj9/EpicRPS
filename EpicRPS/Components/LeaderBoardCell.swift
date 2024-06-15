//
//  LeaderBoardElement.swift
//

import SwiftUI

struct LeaderBoardCell: View {
    var placeInRankin: Int
    var avatar: String
    var name: String
    var result: Int
    var rate: Int
    var winnerCheck: Bool {
        placeInRankin < 4
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(getBackgroundColor())
            HStack {
                HStack {

                    Image(avatar)
                        .resizableToFit()
                        .frame(height: 37)
                        .padding(.horizontal, 15)
                    Text(name)
                        .font(.custom(.rubikMedium, size: 16))
                        .foregroundStyle(getForegroundColor())
                        .lineLimit(1)
                    Spacer()
                }
                .overlay {
                    if !winnerCheck {
                        HStack {
                            Text("\(placeInRankin)")
                                .font(.custom(.rubikRegular, size: 10))
                                .foregroundStyle(.rpsSecondTextForCell)
                            Spacer()
                        }
                    }
                }
                HStack {
                    Text("\(getPoints())")
                        .font(.custom(.rubikBold, size: 16))
                        .foregroundStyle(winnerCheck ? .rpsTextForCell : .rpsDefaultTextForCell)
                    Spacer()
                    Text("\(rate.description)%")
                        .font(.custom(.rubikBold, size: 22))
                }
                .padding(.horizontal, 20)
            }
            if winnerCheck {
                HStack {
                    Spacer()
                    Image(getMedal())
                        .resizableToFit()
                        .frame(height: 19)
                        .offset(x: 8)
                }
            }
        }

        .frame(height: winnerCheck ? 65 : 55)
        .padding(.horizontal, 30)

    }
    private func getBackgroundColor() -> Color {
        switch placeInRankin {
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

    private func getPoints() -> String {
        if result < 1000 {
            return String(result)
        }
        let text = Double(result) / 1000
        return String(format: "%.3f", text)
    }
    private func getForegroundColor() -> Color {
        switch placeInRankin {
        case 1:
            return Color("rpsFirstTextForCell")
        case 2:
            return Color("rpsSecondTextForCell")
        case 3:
            return Color("rpsThirdTextForCell")
        default:
            return Color("rpsTextForCell")
        }
    }

    private func getMedal() -> String {
        switch placeInRankin {
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

#Preview {
    LeaderBoardCell(
        placeInRankin: 4, avatar: "avatarTest", name: "Herman Welnchs", result: 20000, rate: 32)
}
