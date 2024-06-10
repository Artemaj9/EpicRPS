//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
  @State private var firstAnim = false
  @State private var secondAnim = false
  @State private var opacity: Double = 0

  var body: some View {
    ZStack {
      Color(.rpsLightGray)
        .ignoresSafeArea()
      VStack {
        HStack {
          // Settings button
          Button {

          } label: {
            Image("settings-icon")
          }
          Spacer()

          Button {

          } label: {
            Image("help-icon")
          }
        }
        .padding(18)
        .opacity(opacity)
        .animation(.smooth(duration: 1).delay(1.5), value: opacity)

        Spacer()
        VStack {
          HStack {
            Spacer()
            Image("male-rock-cut")
              .resizableToFit()
              .offset(x: secondAnim ? 0 : 200)
              .scaleEffect(secondAnim ? 1.2 : 0.8)
          }

          Text("EPIC RPS")
            .font(Font.custom(.rubikBold, size: 30))
            .foregroundStyle(.rpsLightPeach)
            .shadow(color: .rpsDarkPeach, radius: 0, x: 2, y: 2)
            .padding(.vertical, 50)
            .scaleEffect(firstAnim ? 1 : 0)

          HStack {
            Image("female-scissors-cut")
              .resizableToFit()
              .offset(x: secondAnim ? 0 : -200)
              .scaleEffect(secondAnim ? 1.2 : 0.8)
            Spacer()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: 310)
        .padding(.vertical, 30)
        VStack(spacing: 20) {

          // Start button
          Button {
          } label: {
            ZStack {
              RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.rpsDarkPeach)
                .shadow(color: .rpsShadowPeach, radius: 0, y: 6)
              HStack {
                RoundedRectangle(cornerRadius: 25)
                  .foregroundStyle(.rpsLightPeach)
                Spacer(minLength: 100)
              }
              Text("START")
                .font(.custom("Rubik-Bold", fixedSize: 16))
                .foregroundStyle(.rpsPeachText)
            }
            .frame(maxHeight: 54)
          }
          // Result button
          Button {
            //some action
          } label: {
            ZStack {
              RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.rpsDarkPeach)
                .shadow(color: .rpsShadowPeach, radius: 0, y: 6)
              HStack {
                RoundedRectangle(cornerRadius: 25)
                  .foregroundStyle(.rpsLightPeach)
                Spacer(minLength: 100)
              }
              Text("RESULT")
                .font(Font.custom(.rubikBold, size: 16))
                .foregroundStyle(.rpsPeachText)
            }
            .frame(maxHeight: 54)
          }
        }
        .frame(maxWidth: 200, maxHeight: 200)
        .opacity(opacity)
        .animation(.easeIn(duration: 0.5).delay(1), value: opacity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.rpsLightGray)
      .onAppear {
        firstAnim.toggle()
        opacity = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
          secondAnim.toggle()
        }
      }
      .animation(.bouncy(duration: 1, extraBounce: 0.3), value: firstAnim)
      .animation(.easeOut(duration: 1).delay(0.05), value: secondAnim)
    }
    .preferredColorScheme(.light)
  }
}

#Preview {
  MainView()
}
