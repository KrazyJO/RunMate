//
//  ContentView.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

struct TimerView: View {
    @State private var remainingTime: Int = (0*60)+5
    @State private var isRunning = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var playPauseIcon = Icons.pause
    
    private var timeString: String {
        let (_,m,s) = secondsToHoursMinutesSeconds(remainingTime)
        return "\(withLeadingZero(m)):\(withLeadingZero(s))"
    }
    
    private var playPauseButtonIcon: String {
        return isRunning ? "pause.circle.fill" : "play.circle.fill"
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Distance: 2.4km").normal()
                Text("fast").normal()
                Text(timeString).large()
                    .onReceive(timer) { time in
                            timerEvent()
                    }
                    
                
                Text("Round 1 of 4").normal()
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                ZStack {
                    ActionButtons(playPauseIcon: playPauseIcon) {
                        print("forward")
                    } backwardAction: {
                        print("backward")
                    } playPauseAction: {
                        playPausePressed()
                    }
                }
                Text("distance: 2,4km").normal()
            }
        }
    }
    
    private func playPausePressed() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func timerEvent() {
        countDownTimer()
        if timeIsOver() {
            stopTimer()
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
    
    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func withLeadingZero(_ iput: Int) -> String {
        return iput < 10 ? "0\(iput)" : "\(iput)"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
