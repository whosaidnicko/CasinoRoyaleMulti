//
//  OrelReshkaIgra.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//


import SwiftUI



struct OrelReshkaIgra: View {
    @State var isSpinning: Bool = false
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var sunChoosed: Bool = false
    @State var showMoneyTake: Bool = false
    @State var sun: Bool?
    @State var timer: Timer?
    @State var betted: Bool = false
    @State var userWin: Bool?
    @State var bet: Int = 0
    @State private var rotation: Double = 0.0
    @State private var flipped = false
    @State var randomRotating: Bool = false
    var body: some View {
        ZStack {
            Image("bgRed")
                .resizable()
                .ignoresSafeArea()
            
            HStack {
                if !betted {
                    VStack {
                        HStack(spacing: 3) {
                            Button {
                                let decrement = 0.10 * Double(self.userStorage.coin)
                                let newBet = bet - Int(decrement)
                                // Ensure the bet does not go below zero
                                if newBet >= 0 {
                                    bet = newBet
                                } else {
                                    bet = 0
                                }
                            } label: {
                                Image("menuLeibl")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .overlay {
                                        Text("-")
                                            .font(.custom(Font.lalezar, size: 25))
                                            .foregroundStyle(.white)
                                    }
                            }
                            .buttonStyle(CustomStyle())
                            
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 141, height: 45)
                                .overlay {
                                    Text(String(bet))
                                        .font(.custom(Font.lalezar, size: 25))
                                        .foregroundStyle(.white)
                                }
                            
                            Button {
                                let increment = 0.10 * Double(self.userStorage.coin)
                                let newBet = bet + Int(increment)
                                
                                // Ensure the bet does not exceed current money
                                if newBet <= self.userStorage.coin {
                                    if newBet == 0 {
                                        self.bet = self.userStorage.coin
                                    } else {
                                        bet = newBet
                                    }
                                    
                                }
                                if self.userStorage.coin == 0 {
                                    withAnimation {
                                        self.showMoneyTake = true
                                    }
                                }
                            } label: {
                                Image("menuLeibl")
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
                        Button(action: {
                            withAnimation {
                                
                                self.betted = true
                            }
                        }, label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 141, height: 45)
                                .overlay {
                                    Text("Next")
                                        .font(.custom(Font.lalezar, size: 25))
                                        .foregroundStyle(.white)
                                }
                        })
                        .buttonStyle(CustomStyle())
                        .scaleEffect(!self.isSpinning  ? 1 : 0)
                        .disabled(self.bet == 0)
                        .animation(Animation.easeInOut(duration: 1.2), value: self.bet)
                    }
                    .scaleEffect(!self.isSpinning  ? 1 : 0)
                    
                    
                } else {
                    if sun == nil {
                        Image("sun")
                            .onTapGesture {
                                withAnimation {
                                    sunChoosed = true
                                    sun = true
                                    userStorage.coin -= bet
                                    flipingCoin()
                                }
                            }
                        
                        Image("moon")
                            .onTapGesture {
                                withAnimation {
                                    sunChoosed = false
                                    sun = false
                                    userStorage.coin -= bet
                                    flipingCoin()
                                }
                            }
                    } else {
                        Image(sun! ? "sun" : "moon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .rotation3DEffect(
                                .degrees(rotation),
                                axis: (x: 1.0, y: 0.0, z: 0.0)
                            )
                            .animation(.easeInOut, value: rotation)
                            .onTapGesture {
                                
                            }
                    }
                    //
                }
            }
            MoneyAlert(moneyAlert: $showMoneyTake)
            
            if userWin != nil {
                DidUserShowWin(bablosiki: bet * 2,
                             experince: Int.random(in: 50...100),
                             userWin: userWin!, isFreeRoulette: false) {
                    withAnimation {
                        bet = 0
                        betted = false
                        sun = nil
                        userWin = nil
                    }
                }
                             .scaleEffect(self.userWin != nil ? 1 : 0)
            }
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NazadKnopocika())
        .navigationBarItems(trailing: GoldView())
        .onAppear() {
            userStorage.energy -= 1
        }
    }
    
    
    func flipingCoin() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
            withAnimation {
                    // Rotate the coin
                    rotation += 180
                    // Wait a moment for the rotation to complete, then flip the coin
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        sun!.toggle()
                        flipped.toggle()
                        // Reset rotation for the next flip
                        rotation += 180
                    }
                }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 5...10)) {
            timer?.invalidate()
            rotation += 180
            // Wait a moment for the rotation to complete, then flip the coin
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sun!.toggle()
                flipped.toggle()
                // Reset rotation for the next flip
                rotation += 180
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if sunChoosed == sun {
                    userWin = true
                } else {
                    userWin = false
                }
            }
        }
    }
}
