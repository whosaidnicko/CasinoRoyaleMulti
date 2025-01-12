//
//  BacklBtn.swift
//  CasinoRoyaleMulti
//
//  Created by Jack Betha on 31/12/2024.
//

import Foundation
import SwiftUI

struct NazadKnopocika: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            self.dismiss()   
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.000001))
                    .frame(height: 30)
                Image("backbtn")
            }
        }
        .buttonStyle(CustomStyle())
    }
}
extension Font {
    static var lalezar: String = "Lalezar-Regular"
}
