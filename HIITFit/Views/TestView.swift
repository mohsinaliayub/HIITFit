//
//  TestView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("High Five!")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("""
                Good job completing all four exercises!
                Remember tomorrow's another day.
                So eat well and get some rest.
                """)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
