//
//  RPSFont.swift
//

import SwiftUI

enum RPSFont: String {
    case rubicRegular = "Rubic-Regular"
    case rubikMedium = "Rubic-Medium"
    case rubicBold = "Rubic-Bold"
}

extension Font {
    static func custom(_ font: RPSFont, size: CGFloat) -> Font {
        Font.custom(font.rawValue, size: size)
    }
}
