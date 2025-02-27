//
//  LoadingViewCard.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//

import Foundation
import SwiftUI

struct RasstaviKartociki: View {
    @EnvironmentObject private var userStorageGame: UserStorageGameClass
    @State var navigate: Bool = false
    @State var goToMen: Bool = false
    @State var cards: [String] = []
    @State var animate: Bool = false
    @State var showCard: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink("",
                           destination: viewDestination(), isActive: $navigate)
            Image("bgRed")
                .resizable()
                .ignoresSafeArea()
            
            
            HStack {
                Spacer()
                
                ZStack {
                    ForEach(cards.indices, id: \.self) { index in
                        Image(index > 9 ? (showCard ? cards[index] : "backOblojk") : "backOblojk")
                            .resizable()
                            .frame(width: 39.16, height: 58)
                            .rotation3DEffect(
                                .degrees(index > 9 && self.showCard ? 90 : 360), //
                                axis: (x: -1, y: -1, z: 0)
                            )
                            .offset(x: index > 9  && animate ? -UIScreen.main.bounds.width - 145  + ( CGFloat(index * 45)) :  CGFloat( 8 * index),
                                    y: index > 9  && animate ? 0 : 0 )
                            .animation(.easeInOut(duration: 0.5).delay(TimeInterval(Double(index) * 0.1)), value: self.animate)
                            .animation(.easeInOut.delay(TimeInterval(Double(index) * 0.1)), value: self.showCard)
                        
                        
                    }
                }
                .offset(x: -130)
                .padding(.bottom)
                
            }
            .onAppear() {
                for card in 1...10 {
                    cards.append(String(card).appending("c"))
                }
                
                for character in "LOADING" {
                    cards.append(String(character))
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animate = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showCard = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showCard = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                animate = false
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    self.navigate = true
                                }
                            }
                        }
                    }
                }
            }
        }
        .mixAdapt()
    }
}


