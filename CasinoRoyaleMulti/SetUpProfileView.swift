//
//  SetUpProfileView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct SetUpProfileView: View {
    @StateObject  var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var goText: Bool = false
    @State var goMenu: Bool = false
    @State var setName: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack {
                Group {
                    if !self.goText {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(self.userStorage.logos.indices, id: \.self) { index in
                                    Image(self.userStorage.logos[index])
                                        .offset(y: self.userStorage.selectedLogo == self.userStorage.logos[index] ? 250 : 0)
                                        .rotationEffect(.degrees(self.userStorage.selectedLogo == self.userStorage.logos[index] ? 360 : 0))
                                        .scaleEffect(self.userStorage.selectedLogo == self.userStorage.logos[index] ? 1.2 : 1)
                                        .animation(.easeInOut(duration: 2), value: self.userStorage.selectedLogo)
                                        .onTapGesture {
                                            self.userStorage.selectedLogo = self.userStorage.logos[index]
                                        }
                                }
                            }
                        }
                    } else {
                        self.chooseNickname()
                        
                        
                    }
                }
                
                .transition(.scale)
                
                Group {
                    if !self.userStorage.selectedLogo.isEmpty && !self.goText  {
                        Button(action: {
                            withAnimation {
                                self.goText = true
                            }
                        }, label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 164, height: 50)
                                .overlay {
                                    Text("CONTINUE")
                                        .font(.custom(Font.lalezar, size: 15))
                                        .foregroundStyle(.white)
                                }
                        })
                        .buttonStyle(CustomStyle())
                    
                    } else if !self.userStorage.name.isEmpty && self.goText {
                     NavigationLink("", destination: MainMenu(), isActive: $goMenu)
                        Button {
                            UserDefaults.standard.setValue(true, forKey: "passed")
                            self.goMenu = true
                        } label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 164, height: 50)
                                .overlay {
                                    Text("CONTINUE")
                                        .font(.custom(Font.lalezar, size: 15))
                                        .foregroundStyle(.white)
                                }
                        }
                        .buttonStyle(CustomStyle())
                    }
                }
                .transition(.scale)
                .animation(.easeInOut(duration: 2), 
                           value: self.userStorage.selectedLogo)
                .padding(.bottom)
            }
        }

        .navigationBarBackButtonHidden()
    }
    
    internal func chooseNickname() -> some View {
        Image("rectName")
            .overlay {
                VStack {
                    Text("CHOOSE YOUR NICKNAME")
                        .font(.custom(Font.lalezar, size: 17))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.white
                            ,lineWidth: 3)
                        .overlay {
                            HStack {
                                TextField("", text: $userStorage.name, prompt: Text("NAME")
                                    .foregroundColor(.white)
                                    .font(.custom(Font.lalezar, size: 20))
                                )
                                .foregroundStyle(.white)
                                  
                                    
                                    .padding(.horizontal)
                                Spacer()
                            }
                        }
                        .frame(width: 194, height: 28)
                }
                .padding()
            }
    }
}

