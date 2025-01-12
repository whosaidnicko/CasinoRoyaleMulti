//
//  SettingsView.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//

import Foundation
import SwiftUI
import StoreKit

struct SettingsView: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    var body: some View {
        ZStack {
            Image("bgRed")
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
                     
                                 Text("-")
                                    .font(.custom(Font.lalezar, size: 25))
                                    .foregroundStyle(.white)
                            
                    }
                    .buttonStyle(CustomStyle())

                  
                            VStack() {
                                Text("Sounds")
                                    .font(.custom(Font.lalezar, size: 17))
                                    .foregroundStyle(.white)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .trim(from: 0, to: 1 * self.userStorage.soundVolume)
                                    .fill(LinearGradient(colors: [Color.init(hex: "#3F56F0"), Color.init(hex: "#00EFA9")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 102 , height: 11)
                            }
                        
                    
                    Button {
                        if self.userStorage.soundVolume != 1 {
                            withAnimation(Animation.easeInOut(duration: 0.5)){
                                self.userStorage.soundVolume += 0.1
                            }
                        }
                    } label: {
                                 Text("+")
                                    .font(.custom(Font.lalezar, size: 25))
                                    .foregroundStyle(.white)
                            
                    }
                    .buttonStyle(CustomStyle())
                }
          
                Button {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                
                } label: {
                    Image("menuLeibl")
                        .overlay {
                            Text("Rate Us")
                                .font(.custom(Font.lalezar, size: 30))
                                .foregroundStyle(.white)
                        }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: GoldView())
        .navigationBarItems(leading: NazadKnopocika())
    }
}









