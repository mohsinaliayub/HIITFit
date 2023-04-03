//
//  WelcomeView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 09.03.23.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var selectedTab: Int
    @State private var showHistory = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab,
                           titleText: NSLocalizedString("Welcome", comment: "greeting"))
                Spacer()
                
                // container view
                ContainerView {
                    VStack {
                        WelcomeView.images
                        WelcomeView.welcomeText
                        getStartedButton
                        Spacer()
                        historyButton
                    }
                }
                .frame(height: geometry.size.height * 0.8)
            }
            .sheet(isPresented: $showHistory) {
                HistoryView(showHistory: $showHistory)
            }
        }
    }
    
    var getStartedButton: some View {
        RaisedButton(buttonText: "Get Started") {
            selectedTab = 0
        }
        .padding()
    }
    
    var historyButton: some View {
        Button {
            showHistory = true
        } label: {
            Text(NSLocalizedString("History", comment: "view user activity"))
                .fontWeight(.bold)
                .padding([.leading, .trailing], 10)
        }
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(selectedTab: .constant(9))
    }
}
