//
//  CreatorView.swift
//  RunMate
//
//  Created by Jörn Otte on 25.02.23.
//

import SwiftUI

struct CreatorView: View {

    @State private var showRoundsSheets = false
    @State private var showPreparationsSheet = false
    @State private var showWorkoutSheet = false
    @State private var showPauseSheet = false
    
    @State private var roundsSelected = 0
    @State private var prepariontsSelection = 0
    @State private var workoutSelection = 0
    @State private var pauseSelection = 0
    
    var body: some View {
        NavigationView {
            VStack {
                
                Button("Preparation: \(prepariontsSelection)") {
                    showPreparationsSheet.toggle()
                }.sheet(isPresented: $showPreparationsSheet) {
                    TimeSelectorView(secondsSelected: $prepariontsSelection)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                }
                
                Button("Workout: \(workoutSelection)") {
                    showWorkoutSheet.toggle()
                }.sheet(isPresented: $showWorkoutSheet) {
                    TimeSelectorView(secondsSelected: $workoutSelection)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                }
                
                Button("Pause: \(pauseSelection)") {
                    showPauseSheet.toggle()
                }.sheet(isPresented: $showPauseSheet) {
                    TimeSelectorView(secondsSelected: $pauseSelection)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                }
                
                Button("Rounds: \(roundsSelected)") {
                    showRoundsSheets.toggle()
                }.sheet(isPresented: $showRoundsSheets) {
                    RoundsSelectorView(roundsSelected: $roundsSelected)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                }
                
                Button("START") {
                    
                }.padding(.top, 20).font(.system(size: 32))
                
                
            }
            .navigationTitle("Setup")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
