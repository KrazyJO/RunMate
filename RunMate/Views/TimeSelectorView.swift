//
//  TimeSelectorView.swift
//  RunMate
//
//  Created by Jörn Otte on 26.02.23.
//

import SwiftUI

struct TimeSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var secondsSelected: Int

    @State var selectedMinutes = 0
    @State var selectedSeconds = 0

    private let seconds = 0...60
    private let minutes = 0...99

    private func calcSecsAndMinsForWheels() {
        if secondsSelected < 1 {
            return
        }

        let mins = secondsSelected / 60
        let secs = secondsSelected - (mins * 60)

        selectedMinutes = mins
        selectedSeconds = secs
    }

    func calcSelectedToSeconds() {
        secondsSelected = (selectedMinutes * 60) + selectedSeconds
    }

    var body: some View {
        Group {
            Form {
                Section {
                    HStack {
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(minutes, id: \.self) {
                                Text("\($0) min").foregroundColor(.blue)
                            }
                        }.pickerStyle(.wheel)

                        Picker("Seconds", selection: $selectedSeconds) {
                            ForEach(seconds, id: \.self) {
                                Text("\($0) sec").foregroundColor(.blue)
                            }
                        }.pickerStyle(.wheel)
                    }

                    HStack {
                        Spacer()
                        Button("Ok") {
                            calcSelectedToSeconds()
                            dismiss()
                        }
                        .font(.title)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            dismiss()
                        }
                        .font(.title)
                        Spacer()
                    }
                }

            }
        }
        .navigationTitle("Select your rounds")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            calcSecsAndMinsForWheels()
        }
    }
}

struct TimeSelectorView_Previews: PreviewProvider {

    static var previews: some View {
        TimeSelectorView(secondsSelected: .constant(184))
    }
}
