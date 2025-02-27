//
//  MoneyAlert.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024..
//

import Foundation
import SwiftUI

struct MoneyAlert: View {
    @StateObject private var storageUser: UserStorageGameClass = UserStorageGameClass.shared
    @Binding var moneyAlert: Bool
    var body: some View {
        Image("rectName")
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.moneyAlert = false
                            }
                        }, label: {
                            Image("closeIc")
                        })
                        .buttonStyle(CustomStyle())
                    
                    }
                    
                    Text("Not enough money to continue")
                        .font(.custom(Font.lalezar, size: 12))
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                    
                    Button(action: {
                        if !self.storageUser.moneyIsDisable {
                            self.storageUser.coin += 100
                            self.storageUser.goldPressed()
                            withAnimation {
                                self.moneyAlert = false
                            }
                        }
                    }, label: {
                     
                                HStack {
                                    Text(self.storageUser.moneyIsDisable ? self.storageUser.goldRemainingTimer : "Claim")
                                        .font(.custom(Font.lalezar, size: 15))
                                        .foregroundStyle(.white)
                                    
                                    if !self.storageUser.moneyIsDisable {
                                        Text("100")
                                            .font(.custom(Font.lalezar, size: 20))
                                            .foregroundStyle(.white)
                                        
                                        Image("popro")
                                            .resizable()
                                            .frame(width: 33, height: 27)
                                    }
                                
                            }
                    })
                    .buttonStyle(CustomStyle())
                    Spacer()
                }
            }
            .scaleEffect(self.moneyAlert ? 1 : 0)
    }
}
