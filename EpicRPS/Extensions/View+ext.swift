//
//  View+ext.swift
//

import SwiftUI

extension View {
    func runAfterAppear(delay: Double, action: @escaping () -> ()) -> some View {
        onAppear {
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
                withAnimation {
                    action()
                }
            }
        }
    }
}
