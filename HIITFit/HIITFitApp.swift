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
    @State private var showAlert = false
    
    init() {
        let historyStore: HistoryStore
        do {
            historyStore = try HistoryStore(withChecking: true)
        } catch {
            showAlert = true
            print("Could not load history data")
            historyStore = HistoryStore()
        }
        
        _historyStore = StateObject(wrappedValue: historyStore)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyStore)
                .alert("History", isPresented: $showAlert) {
                    
                } message: {
                    Text(
                        """
                        Unfortunately we can't load your past history.
                        Email support: support@xyz.com
                        """
                    )
                }

        }
    }
}
