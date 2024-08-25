//
//  ContentView.swift
//  CheddarWipeout
//
//  Created by Timea Bartha on 22/8/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var cryptoManager = CryptoManager.shared
    var body: some View {
            NavigationView {
                List(cryptoManager.coins.sorted(by: { $0.currentPrice > $1.currentPrice })) { coin in
                    CryptoRowView(viewModel: CryptoCoinViewModel(coin: coin))
                }
                .navigationTitle("Cheddar Market")
            }
        }
    
    }
#Preview {
    ContentView()
}
