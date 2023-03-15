//
//  CreatorView.swift
//  RunMate
//
//  Created by Jörn Otte on 25.02.23.
//

import SwiftUI

struct CreatorView: View {
    
    @EnvironmentObject private var navigationPath: NavigationPath

    @State private var showRoundsSheets = false
    @State private var showPreparationsSheet = false
    @State private var showWorkoutSheet = false
    @State private var showPauseSheet = false

    @State private var roundsSelected = 1
    @State private var prepariontsSelection = 0
    @State private var workoutSelection = 0
    @State private var pauseSelection = 0

    func timeToString(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second]
        if seconds > 59 {
            formatter.allowedUnits.insert(.minute)
        }
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .brief

        let formatted = formatter.string(from: TimeInterval(seconds)) ?? ""
        return formatted
    }

    var body: some View {
        VStack {

            Button("Preparation: \(timeToString(seconds: prepariontsSelection))") {
                showPreparationsSheet.toggle()
            }.padding(.bottom, 5)
            .sheet(isPresented: $showPreparationsSheet) {
                TimeSelectorView(secondsSelected: $prepariontsSelection)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }

            Button("Workout: \(timeToString(seconds: workoutSelection))") {
                showWorkoutSheet.toggle()
            }.padding(.bottom, 5)
            .sheet(isPresented: $showWorkoutSheet) {
                TimeSelectorView(secondsSelected: $workoutSelection)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }

            Button("Pause: \(timeToString(seconds: pauseSelection))") {
                showPauseSheet.toggle()
            }.padding(.bottom, 5)
            .sheet(isPresented: $showPauseSheet) {
                TimeSelectorView(secondsSelected: $pauseSelection)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }

            Button("Rounds: \(roundsSelected)") {
                showRoundsSheets.toggle()
            }.padding(.bottom, 5)
            .sheet(isPresented: $showRoundsSheets) {
                RoundsSelectorView(roundsSelected: $roundsSelected)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }

            Button("START") {
                let def = TimerDefinition(preparation: prepariontsSelection,
                                          workout: workoutSelection,
                                          pause: pauseSelection,
                                          rounds: roundsSelected)
                
                navigationPath.toPreparation(definition: def)
            }

        }
        .navigationTitle("Setup")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
