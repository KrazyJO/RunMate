//
//  RoundsSelectorView.swift
//  RunMate
//
//  Created by Jörn Otte on 26.02.23.
//

import SwiftUI

struct RoundsSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var roundsSelected: Int

    var rounds = 0...10

    var body: some View {
        Group {
            Form {
                Section {
                    Picker("Rounds", selection: $roundsSelected) {
                        ForEach(rounds, id: \.self) {
                            Text("\($0) Rounds").foregroundColor(.blue)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.top, 20)

                    HStack {
                        Spacer()
                        Button("Ok") {
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
    }
}

struct RoundsSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        RoundsSelectorView(roundsSelected: .constant(2))
    }
}
