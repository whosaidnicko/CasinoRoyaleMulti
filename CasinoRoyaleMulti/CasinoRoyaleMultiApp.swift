//
//  CasinoRoyaleMultiApp.swift
//  CasinoRoyaleMulti
//
//  Created by Nicolae Chivriga on 31/12/2024.
//

import SwiftUI

@main
struct CasinoRoyaleMultiApp: App {
    @StateObject  private var userStorageGame: UserStorageGameClass = UserStorageGameClass.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingViewCard()
            }
        }
    }
}

