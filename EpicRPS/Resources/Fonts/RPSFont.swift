//
//  RPSFont.swift
//

import SwiftUI

enum RPSFont: String {
    case rubikRegular = "Rubik-Regular"
    case rubikMedium = "Rubik-Medium"
    case rubikBold = "Rubik-Bold"
    case delaGothicOneRegular = "DelaGothicOne-Regular"
    case poppinsSemiBold = "Poppins-SemiBold"
    case poppinsRegular = "Poppins-Regular"
    
}

extension Font {
    static func custom(_ font: RPSFont, size: CGFloat) -> Font {
        Font.custom(font.rawValue, size: size)
    }
}

