//
//  TimerHelper.swift
//

import SwiftUI

func performAction(after interval: TimeInterval, action: @escaping () -> Void) {
    Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { timer in
        withAnimation {
            action()
        }
    }
}

