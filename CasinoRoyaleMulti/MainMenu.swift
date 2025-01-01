//
//  MenuJkView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct MainMenu: View {
    @State var rotation: Double = 0
    @State var showTradeEnergy: Bool = false
    @State var timer: Timer?
    @AppStorage("newPlayer") var newPlayer: Bool = false
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var showAchievments: Bool = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        ]
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack {
                HStack {
                    self.leftBar()
                    
                    Spacer()
                    
                    self.rightBar()
                }
                
                HStack {
                    self.leftStatsUser()
                    
                    Spacer()
                    
                    self.rightRouletteWithCooldown()
                        .offset(x: 10)
                }
                .padding(.top, 22)
            
                VStack(spacing: 32) {
                    NavigationLink {
                        GamesChooseView()
                    } label: {
                        Image("gmsl")
                            .overlay {
                                HStack {
                                    Text("Games")
                                        .font(.custom(Font.lalezar, size: 30))
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                    
                            }
                        
                    }
                    
                    Button {
                        withAnimation {
                            self.showAchievments = true
                        }
                    } label: {
                     Image("achi")
                    }
                    .buttonStyle(CustomStyle())
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image("menuLeibl")
                            .overlay {
                                Text("Settings")
                                    .font(.custom(Font.lalezar, size: 30))
                                    .foregroundStyle(.white)
                            }
                    }

                }
                .padding(.top, 50)
                
              Spacer()
            }
            .padding()
            .blur(radius: self.showAchievments || !self.newPlayer || self.showTradeEnergy ? 3 : 0)
            .disabled(self.showAchievments || !self.newPlayer || self.showTradeEnergy)
            
            Group {
                if self.showAchievments {
                    Image("rectAch")
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        withAnimation {
                                            self.showAchievments = false
                                        }
                                    } label: {
                                        Image("closeIc")
                                    }
                                    .buttonStyle(CustomStyle())
                                }
                                .padding(.trailing, 5)
                                
                                Text("Achievements")
                                    .font(.custom(Font.lalezar, size: 25))
                                    .foregroundStyle(.white)
                                
                                LazyVGrid(columns: columns) {
                                    ForEach(self.userStorage.achievement.indices, id: \.self) { index in
                                        Image(self.userStorage.achievement[index])
                                        
                                    }
                                    
                                }
                                Spacer()
                            }
                        }
                        .frame(width: 354, height: 443)
                } else if showTradeEnergy {
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
                                    Image("settingsLeibl")
                                        .resizable()
                                        .frame(width: 91, height: 42)
                                        .overlay {
                                            Text("Change")
                                                .font(.custom(Font.lalezar
                                                              , size: 15))
                                                .foregroundStyle(.white)
                                        }
                                }
                                .buttonStyle(CustomStyle())
                                Spacer()
                            }
                        }
                }
            }
            .transition(.scale)
            
            Group {
                if !newPlayer {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.init(hex: "#341947"))
                        .overlay {
                            VStack {
                                Image("achievRe")
                                
                                Image("newUserAchievement")
                                
                                Button {
                                    withAnimation {
                                        self.newPlayer = true
                                    }
                                 
                                } label: {
                                    Image("settingsLeibl")
                                        .resizable()
                                        .frame(width: 91, height: 36)
                                        .overlay {
                                             Text("Receive")
                                                .font(.custom(Font.lalezar, size: 15))
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                        }
                        .frame(width: 325, height: 382)
                }
            }
            .transition(.scale)
        }
        .navigationBarBackButtonHidden()
       
        .onAppear() {
            self.checkForAchievements()
        }
    }
    
    internal func leftBar() -> some View {
        Image("plusRe")
            .overlay {
                HStack {
                        HStack {
                                ZStack {
                                    Image("squarePurple")
                                }
                            .offset(x: -5
                                    ,y: 2)
                            .buttonStyle(CustomStyle())
                            
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
            .onTapGesture {
                withAnimation {
                    self.showTradeEnergy = true
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
    
    func leftStatsUser() -> some View {
      Image("okoshk")
            .overlay {
                VStack {
                    
                    Image(self.userStorage.selectedLogo)
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                   
                    Text(self.userStorage.name)
                        .font(.custom(Font.lalezar, size: 12))
                        .foregroundStyle(Color.white)
                    
                    HStack(spacing: 5) {
                      
                        
                        VStack() {
                            StrokeText(text: "\(Int(self.userStorage.currentExperince))/2000", width: 1, color: .white)
                                .font(.custom(Font.lalezar, size: 10))
                                .foregroundStyle(Color.init(hex: "#676666"))
                            
                            Rectangle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 104, height: 10)
                                .overlay(alignment: .leading)  {
                                    Rectangle()
                                        .fill(Color.init(hex: "#FFD700"))
                                        .frame(width: 104 * (self.userStorage.currentExperince / 2000), height: 5)
                                        .padding(.horizontal, 6)
                                }
                        }
                        
                    }
                    .padding(.bottom, 6)
                }
            }
            .frame(width: 155, height: 200)
    }
    func rightRouletteWithCooldown() -> some View {
        NavigationLink {
            FreeRouletteView(isFree: true)
        } label: {
            Image("okoshk")
                .overlay {
                    VStack {
                        Image("torquz")
                            .resizable()
                            .frame(width: 70, height: 64)
//                            .rotationEffect(.degrees(rotation))
                            .padding(.top, 24)
                        
                        Text("Daily Roulette")
                            .font(.custom(Font.lalezar, size: 12))
                            .foregroundStyle(Color.white)
                            .padding()
                    
                        
                        Image("menuLeibl")
                            .resizable()
                            .frame(width: 85, height: 18)
                            .overlay {
                                Text(self.userStorage.roultteIsDisabled ? self.userStorage.rouletteRemainingTimeText : "SPIN")
                                    .font(.custom(Font.lalezar, size: 12))
                                    .foregroundStyle(.white)
                                
                            }
                            .padding(.top, -10)
                            
                        Spacer()
                }
               

        }
                .frame(width: 155, height: 177)
                .onAppear() {
//                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
//                        rotation += 1
//                    }
                }
                
        }
        .disabled(self.userStorage.roultteIsDisabled)

      
    }
    
    func checkForAchievements() {
        UserDefaults.standard.setValue("newUserAchievement", forKey: "newUserAchievement")
        
        let achievements = [UserDefaults.standard.value(forKey: "newUserAchievement"), UserDefaults.standard.value(forKey: "firstPlayJB"), UserDefaults.standard.value(forKey: "cardWinAchievement"), UserDefaults.standard.value(forKey: "rouletteFreeAchievement")]
        for achievement in achievements {
            if achievement != nil {
                if !self.userStorage.achievement.contains(achievement as! String) {
                    self.userStorage.achievement.append(achievement as! String)
                }
            }
        }
    }
}


struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
