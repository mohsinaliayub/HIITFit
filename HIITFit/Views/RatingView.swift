//
//  RatingView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    private let maximumRating = 5
    private let onColor = Color.red
    private let offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { index in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(index > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        .font(.largeTitle)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
            .previewLayout(.sizeThatFits)
    }
}
