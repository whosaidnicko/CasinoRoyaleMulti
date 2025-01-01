//
//  SettingsView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                HStack {
                    Button {
                        if self.userStorage.soundVolume >= 0.1 {
                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                self.userStorage.soundVolume -= 0.1
                            }
                        }
                    } label: {
                        Image("squareS")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .overlay {
                                 Text("-")
                                    .font(.custom(Font.lalezar, size: 25))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(CustomStyle())

                    Image("achievemenTlebl")
                        .resizable()
                        .frame(width: 141, height: 77)
                        .overlay {
                            VStack() {
                                Text("Sounds")
                                    .font(.custom(Font.lalezar, size: 17))
                                    .foregroundStyle(.white)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .trim(from: 0, to: 1 * self.userStorage.soundVolume)
                                    .fill(LinearGradient(colors: [Color.init(hex: "#3F56F0"), Color.init(hex: "#00EFA9")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 102 , height: 11)
                            }
                        }
                    
                    Button {
                        if self.userStorage.soundVolume != 1 {
                            withAnimation(Animation.easeInOut(duration: 0.5)){
                                self.userStorage.soundVolume += 0.1
                            }
                        }
                    } label: {
                        Image("squareS")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .overlay {
                                 Text("+")
                                    .font(.custom(Font.lalezar, size: 25))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(CustomStyle())
                }
          

            
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: GoldView())
        .navigationBarItems(leading: BacklBtn())
    }
}









