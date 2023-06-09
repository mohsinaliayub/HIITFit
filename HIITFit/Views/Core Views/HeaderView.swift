//
//  HeaderView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 13.03.23.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Int
    let titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
                .foregroundColor(.white)
            HStack {
                ForEach(0 ..< Exercise.exercises.count) { index in
                    ZStack {
                        Circle()
                            .frame(width: 32, height: 32)
                            .opacity(index == selectedTab ? 0.5 : 0)
                        Circle()
                            .frame(width: 16, height: 16)
                    }
                    .foregroundColor(.white)
                }
            }
            .font(.title2)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(selectedTab: .constant(0),titleText: "Squat")
                .previewLayout(.sizeThatFits)
                .background(Color("background"))
            HeaderView(selectedTab: .constant(1), titleText: "Step Up")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
