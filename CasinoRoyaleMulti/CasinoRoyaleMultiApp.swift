//
//  CasinoRoyaleMultiApp.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//

import SwiftUI

@main
struct CasinoRoyaleMultiApp: App {
    @StateObject  private var userStorageGame: UserStorageGameClass = UserStorageGameClass.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RasstaviKartociki()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

