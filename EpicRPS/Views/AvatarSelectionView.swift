//
//  AvatarSelectionView.swift
//

import SwiftUI

struct AvatarSelectionView: View {
    @EnvironmentObject var vm: GameViewModel
    @State var playerInd = 1
    @Binding var check: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .opacity(0.01)
                .onTapGesture {
                    check.toggle()
                }
            VStack {
                VStack{
                    HStack{
                        ForEach(1..<5) { ind in
                            Button {
                                playerInd = ind
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle( playerInd == ind ? .rpsScaleGreen : .rpsLightGray)
                                    Image("character\(ind)")
                                        .resizableToFit()
                                        .frame(width: 29)
                                    if playerInd == ind {
                                        VStack() {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image("vmark-icon")
                                                    .resizableToFit()
                                                    .frame(width: 10)
                                                    .offset(x: -8, y: -8)
                                            }
                                        }
                                    }
                                }
                                .frame(width: 63, height: 63)
                            }
                        }
                    }
                    HStack{
                        ForEach(5..<9) { ind in
                            Button {
                                playerInd = ind
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle( playerInd == ind ? .rpsScaleGreen : .rpsLightGray)
                                    Image("character\(ind)")
                                        .resizableToFit()
                                        .frame(width: 29)
                                    if playerInd == ind {
                                        VStack() {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image("vmark-icon")
                                                    .resizableToFit()
                                                    .frame(width: 10)
                                                    .offset(x: -8, y: -8)
                                            }
                                        }
                                    }
                                }
                                .frame(width: 63, height: 63)
                            }
                        }
                    }
                }
                .background(.rpsLightGray.opacity(0.2))
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.rpsLightGray, lineWidth: 2)
                }
                .padding(.vertical, 20)
                Button {
                    vm.currentPlayer1.avatar = "character\(playerInd)"
                    UserDefaultsService.shared.save(structs: vm.currentPlayer1, forKey: "currentPlayer1")
                    check.toggle()
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(.rpsShadowPeach)
                        Text("OK")
                            .font(.custom(.rubikMedium, size: 17))
                            .foregroundStyle(.rpsLightGray)
                    }
                    .frame(width: 136, height: 37)
                }
                .padding(25)
            }
            .padding(20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 314, height: 328)
            
        }
        .onAppear{
            if let ind = Int(String(vm.currentPlayer1.avatar.popLast()!)) {
                playerInd = ind
            }
        }
        .background(.gray)
    }
}

//#Preview {
//    AvatarSelectionView()
//        .environmentObject(GameViewModel())
//}
