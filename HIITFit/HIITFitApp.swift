//
//  HIITFitApp.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 09.03.23.
//

import SwiftUI

@main
struct HIITFitApp: App {
    @StateObject private var historyStore: HistoryStore
    
    init() {
        let historyStore: HistoryStore
        do {
            historyStore = try HistoryStore(withChecking: true)
        } catch {
            print("Could not load history data")
            historyStore = HistoryStore()
        }
        
        _historyStore = StateObject(wrappedValue: historyStore)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyStore)
        }
    }
}
