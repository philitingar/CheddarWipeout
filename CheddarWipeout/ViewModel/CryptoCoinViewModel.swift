//
//  CryptoViewModel.swift
//  CheddarWipeout
//
//  Created by Timea Bartha on 22/8/24.
//

import Foundation

import SwiftUI

class CryptoCoinViewModel: ObservableObject, Identifiable {
    @Published var id: String
    @Published var name: String
    @Published var currentPrice: Double
    @Published var minPrice: Double
    @Published var maxPrice: Double
    @Published var imageUrl: String?
    @Published var trend: PriceTrendEnum
    
    @Published var priceChangeColor: Color = .black
    @Published var priceChangeBackgroundColor: Color = .clear

    init(coin: CryptoModel) {
        self.name = coin.name
        self.id = coin.id
        self.currentPrice = coin.currentPrice
        self.minPrice = coin.minPrice
        self.maxPrice = coin.maxPrice
        self.imageUrl = coin.imageUrl
        self.trend = coin.trend
        
        switch self.trend {
        case PriceTrendEnum.down:
            priceChangeColor = .white
            withAnimation(.easeIn(duration: 0.7)) {
                priceChangeBackgroundColor = .red
            }
        case PriceTrendEnum.equal:
            priceChangeColor = .black
            withAnimation(.easeIn(duration: 0.7)) {
                priceChangeBackgroundColor = .clear
            }
        case PriceTrendEnum.up:
            priceChangeColor = .white
            withAnimation(.easeIn(duration: 0.7)) {
                priceChangeBackgroundColor = .green
            }
        }
    }
}
