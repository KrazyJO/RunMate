//
//  ContentView.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI
import AVFAudio

struct TimerView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var remainingTime = 0
    @State private var isRunning = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var playPauseIcon = Icons.pause
    
    @State private var audioPlayer: AVAudioPlayer?
    
    @StateObject var definition: TimerDefinition
    
    private var timeString: String {
        DateFormatter.secToTime(seconds: remainingTime)
    }
    
    private var playPauseButtonIcon: String {
        return isRunning ? "pause.circle.fill" : "play.circle.fill"
    }
    
    var body: some View {
        ZStack {
            if definition.currentStep?.type == .workout {
                Color.green.opacity(0.4)
            } else if definition.currentStep?.type == .pause {
                Color.red.opacity(0.4)
            } else {
                Color.yellow.opacity(0.4)
            }
            
            VStack {
                Text(typeToString()).font(.system(size: 46)).padding(.top, 50)
                Spacer().frame(height: 50.0)
                
                Text(roundText())
                    .normal()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                
                Text(timeString).large()
                    .onReceive(timer) { time in
                            timerEvent()
                    }.padding(.bottom, 10)
                
                ZStack {
                    ActionButtons(playPauseIcon: playPauseIcon) {
                        forwardPressed()
                    } backwardAction: {
                        backwardPressed()
                    } playPauseAction: {
                        playPausePressed()
                    }
                }
                Text("distance: 2,4km")
                    .normal()
                    .padding(.top, 100)
                Button("Stop and  Back") {
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
            }
        }.onAppear {
            resetRemainingTimeToCurrentStep()
        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
    
    private func roundText() -> String {
        if let round = definition.currentStep?.round {
            let maxRounds = definition.rounds
            return "Round \(round) of \(maxRounds)"
        }
        
        return ""
    }
    
    private func typeToString() -> String {
        switch definition.currentStep?.type {
        case .workout:
            return "Workout"
        case .preparation:
            return "Preparation"
        case .pause:
            return "Pause"
        case .none:
            return "End"
        }
    }
    
    private func playPausePressed() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func backwardPressed() {
        previousStep()
    }
    
    private func forwardPressed() {
        nextStep()
    }
    
    private func timerEvent() {
        countDownTimer()
        if timeIsOver() {
            playSound()
            nextStep()
        }
    }
    
    private func resetRemainingTimeToCurrentStep() {
        if let step = definition.currentStep {
            remainingTime = step.time
        } else {
            stopTimer()
        }
    }
    
    private func nextStep() {
        definition.nextStep()
        resetRemainingTimeToCurrentStep()
    }
    
    private func previousStep() {
        definition.previousStep()
        resetRemainingTimeToCurrentStep()
    }
    
    private func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "wav") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer!.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func countDownTimer() {
        remainingTime = remainingTime - 1
    }
    
    private func timeIsOver() -> Bool {
        return remainingTime < 1
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
        isRunning = false
        playPauseIcon = Icons.play
    }
    
    private func startTimer() {
        if timeIsOver() {
            return
        }
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        isRunning = true
        playPauseIcon = Icons.pause
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let definition = TimerDefinition(preparation: 2, workout: 5, pause: 2, rounds: 2)
        TimerView(definition: definition)
    }
}
