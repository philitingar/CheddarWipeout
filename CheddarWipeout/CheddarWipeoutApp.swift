//
//  CheddarWipeoutApp.swift
//  CheddarWipeout
//
//  Created by Timea Bartha on 22/8/24.
//

import SwiftUI
import RealmSwift
import CryptoAPI

@main
struct CheddarWipeoutApp: SwiftUI.App {
    @Environment(\.scenePhase) var scenePhase
    var cryptoAPIManager = CryptoManager.shared
    
    init() {
        let config = Realm.Configuration()
        Realm.Configuration.defaultConfiguration = config
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    cryptoAPIManager.connect()
                }
                .onDisappear {
                    cryptoAPIManager.disconnect()
                }
        }
        .onChange(of: scenePhase) { previousPhase, newPhase in
            switch newPhase {
            case .active:
                cryptoAPIManager.connect()
            case .background:
                cryptoAPIManager.disconnect()
            default:
                break
            }
        }
    }
}
