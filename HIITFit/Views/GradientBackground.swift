//
//  GradientBackground.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 27.03.23.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    var gradient: Gradient {
        let color1 = Color("gradient-top")
        let color2 = Color("gradient-bottom")
        let background = Color("background")
        return Gradient(stops: [
            Gradient.Stop(color: color1, location: 0),
            Gradient.Stop(color: color2, location: 0.9),
            Gradient.Stop(color: background, location: 0.9),
            Gradient.Stop(color: background, location: 1)
        ])
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
            .frame(width: 300, height: 300)
            .previewLayout(.sizeThatFits)
    }
}
