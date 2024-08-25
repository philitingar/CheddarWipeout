//
//  Model.swift
//  CheddarWipeout
//
//  Created by Timea Bartha on 22/8/24.
//

import RealmSwift
import SwiftUI

enum PriceTrendEnum: String, PersistableEnum {
    case down
    case equal
    case up
}
// all logic of storing the database should be together
final class CryptoModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var price: Double
    @Persisted var imageUrl: String?
    @Persisted var currentPrice: Double
    @Persisted var minPrice: Double
    @Persisted var maxPrice: Double
    @Persisted var trend: PriceTrendEnum
    
    convenience init(id: String, name: String, currentPrice: Double, imageUrl: String?) {
        self.init()
        self.id = id
        self.name = name
        self.currentPrice = currentPrice
        self.minPrice = currentPrice
        self.maxPrice = currentPrice
        self.imageUrl = imageUrl
        self.trend = PriceTrendEnum.equal
    }
    
    func updatePrice(newPrice: Double) {
        if newPrice == self.currentPrice {
            self.trend = PriceTrendEnum.equal
        } else if newPrice > self.currentPrice {
            self.trend = PriceTrendEnum.up
        } else {
            self.trend = PriceTrendEnum.down
        }
        self.currentPrice = newPrice
        self.minPrice = min(self.minPrice, newPrice)
        self.maxPrice = max(self.maxPrice, newPrice)
    }
    
}
//filter coin name ask for minim or maximum
