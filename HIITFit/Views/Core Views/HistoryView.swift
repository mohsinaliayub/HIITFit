//
//  HistoryView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import SwiftUI

struct HistoryView: View {
    @Binding var showHistory: Bool
    @EnvironmentObject var history: HistoryStore
    
    var body: some View {
        ScrollView {
            ForEach(history.exerciseDays) { day in
                Section(
                    header:
                        HStack {
                            Text(day.date.formatted(as: "MMM d"))
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding()
                            Spacer()
                        },
                    footer:
                        Divider()
                        .padding(.top, 40)
                ) {
                    // Only the first four exercises are shown
                    HStack(spacing: 40) {
                        ForEach(0..<min(day.exercises.count, 4)) { index in
                            let exercise = day.exercises[index]
                            VStack {
                                IndentView {
                                    switch exercise {
                                    case "Squat":
                                        Image(systemName: "bolt.fill")
                                            .frame(minWidth: 60)
                                        //                        .padding(15)
                                    case "Step Up":
                                        Image(systemName: "arrow.uturn.up")
                                            .frame(minWidth: 60)
                                    case "Burpee":
                                        Image(systemName: "hare.fill")
                                            .frame(minWidth: 60)
                                    default:
                                        Image(systemName: "sun.max.fill")
                                            .frame(minWidth: 60)
                                    }
                                }
                                .foregroundColor(Color("exercise-history"))
                                .padding(.bottom, 20)
                                Text(exercise)
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.primary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showHistory: .constant(true))
            .environmentObject(HistoryStore())
    }
}
