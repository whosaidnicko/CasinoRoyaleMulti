//
//  GamesChooseView.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//

import Foundation
import SwiftUI


struct VibiraemIgruliy: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    
    @State var showTradeEnergy: Bool = false
    @State var showMoney: Bool = false
    var body: some View {
        ZStack {
            Image("bgRed")
                .resizable()
                .ignoresSafeArea()
            
            HStack {
                VStack {
                    self.leftBar()
                    
                    
                    
                    self.rightBar()
                }
                
                Spacer()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 29) {
                 
                       Image("bj21leibl")
                            .overlay {
                                HStack(spacing: 21) {
                                    
                                    if self.userStorage.energy > 0 {
                                        NavigationLink {
                                            CiorniiJackIgrush()
                                        } label: {
                                            HStack {
                                                Spacer()
                                                
                                                Image("menuLeibl")
                                                    .resizable()
                                                    .frame(width: 132, height: 45)
                                                    .overlay {
                                                        HStack {
                                                            Text("Play")
                                                                .font(.custom(Font.lalezar, size: 25))
                                                                .foregroundStyle(.white)
                                                            
                                                       
                                                        }
                                                    }

                                            }
                                            .offset(x: -40)
                                        }
                                        //                                        .padding(.horizontal)
                                        //                                        .offset(y: -32)
                                    } else {
                                        Button(action: {
                                            withAnimation {
                                                if self.userStorage.coin >= 50 {
                                                    self.showTradeEnergy = true
                                                } else {
                                                    self.showMoney = true
                                                }
                                            }
                                        }, label: {
                                            HStack {
                                                Spacer()
                                                
                                                Image("menuLeibl")
                                                    .resizable()
                                                    .frame(width: 132, height: 45)
                                                    .overlay {
                                                        HStack {
                                                            Text("Play")
                                                                .font(.custom(Font.lalezar, size: 25))
                                                                .foregroundStyle(.white)
                                                        }
                                                    }

                                            }
                                            .offset(x: -40)

                                            
                                        })
                                        
                                    }
                                    
                                }
                                
                            }
                              
                            
                        
                            .overlay {
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        Spacer()
                                        
                                    
                                            Image("menuLeibl")
                                                .resizable()
                                                .frame(width: 60, height: 20)
                                                .overlay {
                                                    HStack {
                                                        Text("1")
                                                            .font(.custom(Font.lalezar, size: 15))
                                                            .foregroundStyle(.white)
                                                        
                                                        Image("enr")
                                                            .resizable()
                                                            .scaledToFit()
                                                    }
                                                    .padding(.horizontal)
                                                }
                                        

                                    }
                                }
                                .padding()
                                
                            }
                        
                        Image("rouletLei")
                             .overlay {
                                 HStack(spacing: 21) {
                                     
                                     if self.userStorage.energy > 0 {
                                         NavigationLink {
                                             FreeRouletteView(isFree: false)
                                         } label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                             
                                                             
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)
                                         }
                                         //                                        .padding(.horizontal)
                                         //                                        .offset(y: -32)
                                     } else {
                                         Button(action: {
                                             withAnimation {
                                                 if self.userStorage.coin >= 50 {
                                                     self.showTradeEnergy = true
                                                 } else {
                                                     self.showMoney = true
                                                 }
                                             }
                                         }, label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                             
                                                             
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)

                                             
                                         })
                                         
                                     }
                                     
                                 }
                                 
                             }
                               
                             
                         
                             .overlay {
                                 VStack {
                                     Spacer()
                                     
                                     HStack {
                                         Spacer()
                                         
                                     
                                             Image("menuLeibl")
                                                 .resizable()
                                                 .frame(width: 60, height: 20)
                                                 .overlay {
                                                     HStack {
                                                         Text("1")
                                                             .font(.custom(Font.lalezar, size: 15))
                                                             .foregroundStyle(.white)
                                                         
                                                         Image("enr")
                                                             .resizable()
                                                             .scaledToFit()
                                                     }
                                                     .padding(.horizontal)
                                                 }
                                         

                                     }
                                 }
                                 .padding()
                                 
                             }
                        
                        Image("kubikiLeib")
                             .overlay {
                                 HStack(spacing: 21) {
                                     
                                     if self.userStorage.energy > 1 {
                                         NavigationLink {
                                             Kubociki()
                                         } label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)
                                         }
                                         //                                        .padding(.horizontal)
                                         //                                        .offset(y: -32)
                                     } else {
                                         Button(action: {
                                             withAnimation {
                                                 if self.userStorage.coin >= 50 {
                                                     self.showTradeEnergy = true
                                                 } else {
                                                     self.showMoney = true
                                                 }
                                             }
                                         }, label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)

                                             
                                         })
                                         
                                     }
                                     
                                 }
                                 
                             }
                               
                             
                         
                             .overlay {
                                 VStack {
                                     Spacer()
                                     
                                     HStack {
                                         Spacer()
                                         
                                             Image("menuLeibl")
                                                 .resizable()
                                                 .frame(width: 60, height: 20)
                                                 .overlay {
                                                     HStack {
                                                         Text("2")
                                                             .font(.custom(Font.lalezar, size: 15))
                                                             .foregroundStyle(.white)
                                                         
                                                         Image("enr")
                                                             .resizable()
                                                             .scaledToFit()
                                                     }
                                                     .padding(.horizontal)
                                                 }
                                         

                                     }
                                 }
                                 .padding()
                                 
                             }
                        
                        
                        Image("orelIReshka")
                             .overlay {
                                 HStack(spacing: 21) {
                                     
                                     if self.userStorage.energy > 0 {
                                         NavigationLink {
                                             OrelReshkaIgra()
                                         } label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                             
                                                        
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)
                                         }
                                         //                                        .padding(.horizontal)
                                         //                                        .offset(y: -32)
                                     } else {
                                         Button(action: {
                                             withAnimation {
                                                 if self.userStorage.coin >= 50 {
                                                     self.showTradeEnergy = true
                                                 } else {
                                                     self.showMoney = true
                                                 }
                                             }
                                         }, label: {
                                             HStack {
                                                 Spacer()
                                                 
                                                 Image("menuLeibl")
                                                     .resizable()
                                                     .frame(width: 132, height: 45)
                                                     .overlay {
                                                         HStack {
                                                             Text("Play")
                                                                 .font(.custom(Font.lalezar, size: 25))
                                                                 .foregroundStyle(.white)
                                                         }
                                                     }

                                             }
                                             .offset(x: -40)

                                             
                                         })
                                         
                                     }
                                     
                                 }
                                 
                             }
                               
                             
                         
                             .overlay {
                                 VStack {
                                     Spacer()
                                     
                                     HStack {
                                         Spacer()
                                         
                                         Image("menuLeibl")
                                             .resizable()
                                             .frame(width: 60, height: 20)
                                             .overlay {
                                                 HStack {
                                                     Text("1")
                                                         .font(.custom(Font.lalezar, size: 15))
                                                         .foregroundStyle(.white)
                                                     
                                                     Image("enr")
                                                         .resizable()
                                                         .scaledToFit()
                                                 }
                                                 .padding(.horizontal)
                                             }
                                         
                                         
                                     }
                                 }
                                 .offset(x: -8, y: -20)
                             }
                                 .padding()

                                 
                    }
                    .padding(.top, 100)
                }
                Spacer()
                
            }
            .padding(.horizontal)
            .blur(radius: self.showTradeEnergy ? 3 : 0)
            
            showTradeEnery()
                .scaleEffect(self.showTradeEnergy ? 1 : 0)
            
            MoneyAlert(moneyAlert: self.$showMoney)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NazadKnopocika())
    }
    
    func showTradeEnery() -> some View {
        Image("rectName")
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                            self.showTradeEnergy = false
                            }
                        } label: {
                            Image("closeIc")
                        }
                    }
                    HStack {
                        Text("50")
                            .font(.custom(Font.lalezar, size: 20))
                            .foregroundStyle(Color.white)
                        
                        Image("popro")
                            .resizable()
                            .frame(width: 34, height: 28.5)
                        
                        Text("=")
                            .font(.custom(Font.lalezar, size: 25))
                            .foregroundStyle(.white)
                        
                        Text("1")
                            .font(.custom(Font.lalezar, size: 25))
                            .foregroundStyle(.white)
                        
                        Image("enr")
                            .resizable()
                            .frame(width: 31, height: 33)
                    }
                    Button {
                    if self.userStorage.coin >= 50 {
                            self.userStorage.coin -= 50
                            self.userStorage.energy += 1
                        }
                    } label: {
                       
                                Text("Change")
                                    .font(.custom(Font.lalezar
                                                  , size: 15))
                                    .foregroundStyle(.white)
                            
                    }
                    .buttonStyle(CustomStyle())
                    
                    
                    
                    Spacer()
                }
            }
    }
    internal func leftBar() -> some View {
        Image("plusRe")
            .overlay {
                HStack {
                        HStack {
                              
                           
                            
                            Spacer()
                            
                            Text(String(self.userStorage.energy))
                                .font(.custom(Font.lalezar, size: 20))
                                .foregroundStyle(.white)
                            
                            
                            
                            Image("enr")
                                .padding(.horizontal)
                        }
                        
                      
               
                    
                    Spacer()
                }
            }
    }
    
    internal func rightBar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Spacer()
                
                Text(String(self.userStorage.coin))
                    .font(.custom(Font.lalezar, size: 20))
                    .foregroundStyle(.white)
                
                Image("popro")
            }
            
            
            HStack {
                Spacer()
                
                Rectangle()
                    .fill(Color.init(hex: "#FFFFFF").opacity(0.4))
                    .frame(width: 132.78, height: 1.45)
            }
        }
        .frame(width: 133)
    }
}
