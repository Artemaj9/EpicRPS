//
//  View+ext.swift
//

import SwiftUI

extension View {
    func runAfterAppear(delay: Double, action: @escaping () -> Void) -> some View {
        onAppear {
            performAction(after: delay) {
                action()
            }
        }
    }

    func readSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(SizeReader(size: size))
    }
}

struct SizeReader: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            size = geo.size
                        }
                        .onChange(of: geo.size) { newSize in
                            size = newSize
                        }
                }
            )
    }
}
