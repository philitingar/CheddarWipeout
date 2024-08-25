//
//  CryptoManager.swift
//  CheddarWipeout
//
//  Created by Timea Bartha on 23/8/24.
//

import Foundation
import CryptoAPI
import RealmSwift
//orchestrates both the persistance and the api
class CryptoManager: ObservableObject, CryptoDelegate {
    static let shared = CryptoManager()
    
    private var crypto: Crypto?
    @Published var coins: [CryptoModel] = []
    
    private init() {
        // Initialize the Crypto object and set the delegate
        crypto = Crypto(delegate: self)
    }
    
    func connect() {
        if case .failure(let error) = crypto?.connect() {
            print("Failed to connect: \(error)")
        }
    }
    
    func disconnect() {
        crypto?.disconnect()
    }
    
    // MARK: - CryptoDelegate Methods
    
    func cryptoAPIDidConnect() {
        print("Connected to Crypto API")
    }
    
    func cryptoAPIDidUpdateCoin(_ coin: Coin) {
        DispatchQueue.main.async {
            self.updatePrice(for: coin)
        }
    }
    
    func cryptoAPIDidDisconnect() {
        print("Disconnected from Crypto API")
    }
    
    // MARK: - Helper Methods
    
    private func updatePrice(for coin: Coin) {
        let realm = try! Realm()
        if let storedCoin = realm.object(ofType: CryptoModel.self, forPrimaryKey: coin.code) {
            try! realm.write {
                storedCoin.updatePrice(newPrice: coin.price)
            }
            updatePublishedCoins()
        } else {
            let newCoin = CryptoModel(
                id: coin.code,
                name: coin.name,
                currentPrice: coin.price,
                imageUrl: coin.imageUrl
            )
            try! realm.write {
                realm.add(newCoin)
            }
            updatePublishedCoins()
        }
    }
    
    private func updatePublishedCoins() {
        let realm = try! Realm()
        let allCoins = realm.objects(CryptoModel.self)
        DispatchQueue.main.async {
            self.coins = Array(allCoins)
        }
    }
}
