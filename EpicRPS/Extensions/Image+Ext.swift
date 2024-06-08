//
//  Image+ext.swift
//

import SwiftUI

extension Image {
    func resizableToFit() -> some View {
        resizable()
            .scaledToFit()
    }

    func resizableToFill() -> some View {
        resizable()
            .scaledToFill()
    }
}
