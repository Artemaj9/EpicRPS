//
//  SplashView.swift
//

/*
 Это экран, который появляется при запуске приложения.
 Главный экран с меню - MainView
 Splash("всплеск") - это экран загрузки приложения, в фигме не совсем удачный нейминг.
 Cделаем здесь короткую анимацию с иконкой, которую выберем.
 */

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var vm: GameViewModel
    var body: some View {
        Text("Hello, splash")
    }
}

#Preview {
    SplashView()
}
