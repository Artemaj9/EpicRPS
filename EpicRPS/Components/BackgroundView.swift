//
//  BackgroundView.swift
//

import SwiftUI

struct BackgroundView: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var body: some View {
        EllipticalGradient(
            colors: [gradientColor1, gradientColor2],
            center: .center)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView(gradientColor1: .gradient1Dark, gradientColor2: .gradient1Light)
}
