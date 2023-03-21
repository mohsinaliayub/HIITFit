//
//  RatingView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import SwiftUI

struct RatingView: View {
    let exerciseIndex: Int
    // Rating values are stored as a string. There are four exercises in our app,
    // so "ratings" will hold 4 character representing the rating of individual exercise.
    @AppStorage("ratings") private var ratings = "4000"
    @State private var rating = 0
    
    private let maximumRating = 5
    private let onColor = Color.red
    private let offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { index in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(index > rating ? offColor : onColor)
                    .onTapGesture {
                        updateRating(index: index)
                    }
                    .onAppear {
                        // Read the rating value from UserDefaults keyed "ratings",
                        // and get the rating for a specific exercise.
                        let index = ratings.index(ratings.startIndex,
                                                  offsetBy: exerciseIndex)
                        let character = ratings[index]
                        rating = character.wholeNumberValue ?? 0
                    }
            }
        }
        .font(.largeTitle)
    }
    
    private func updateRating(index: Int) {
        rating = index
        // Get the previous rating value of exerciseIndex, and save the
        // new rating value.
        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        ratings.replaceSubrange(index...index, with: String(rating))
    }
}

struct RatingView_Previews: PreviewProvider {
    @AppStorage("ratings") static var ratings: String?
    static var previews: some View {
        ratings = nil
        return RatingView(exerciseIndex: 0)
            .previewLayout(.sizeThatFits)
    }
}
