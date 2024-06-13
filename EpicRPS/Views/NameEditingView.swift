//
//  NameEditingView.swift
//

import SwiftUI

struct NameEditingView: View {
    @EnvironmentObject var vm: GameViewModel
    @Environment (\.dismiss) var dismiss
    @State var name = "Player1"
    var checkBigLetters: Bool {
        name.count > 16
    }
    var checkLetters: Bool {
        name.count <= 2
    }
    @Binding var check: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .opacity(0.01)
                .onTapGesture {
                    UserDefaultsService.shared.save(structs: vm.currentPlayer1, forKey: "currentPlayer1")
                    check.toggle()
                }
            VStack {
                
                HStack {
                    Text("Введите имя игрока")
                        .font(.custom(.rubikRegular, size: 16))
                        .foregroundStyle(.rpsGray)
                    Spacer()
                }
                TextField("Player1", text: $name)
                    .font(.custom(.rubikMedium, size: 23))
                    .padding(15)
                    .background(.rpsLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.gray, lineWidth: 1)
                        
                    }
                Spacer()
                Button {
                    vm.currentPlayer1.name = name
                    UserDefaultsService.shared.save(structs: vm.currentPlayer1, forKey: "currentPlayer1")
                    dismiss()
                    check.toggle()
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(.rpsShadowPeach)
                        Text(checkLetters ? "Еще \(3 - name.count) \(name.count == 2 ? "буква" : "буквы" )" : checkBigLetters ? "Много букв": "OK")
                            .font(.custom(.rubikMedium, size: 17))
                            .foregroundStyle(.rpsLightGray)
                    }
                    .frame(width: 136, height: 37)
                }
                .disabled(checkLetters || checkBigLetters)
                .saturation(checkLetters || checkBigLetters ? 0 : 1)
            }
            .padding(20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 314, height: 196)
            .animation(.easeInOut, value: checkLetters)
            .animation(.easeInOut, value: checkBigLetters)
        }
    }
}

//#Preview {
//    NameEditingView()
//        .environmentObject(GameViewModel())
//}
