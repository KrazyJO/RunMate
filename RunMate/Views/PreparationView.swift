//
//  PreparationView.swift
//  RunMate
//
//  Created by Jörn Otte on 11.03.23.
//

import SwiftUI

struct PreparationView: View {
    
    let color = Color.yellow
    
    @EnvironmentObject private var navigationPath: NavigationPath
    
    @State private var drawingStroke = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var counter: Int
    @State var animation: Animation!
    
    let definition: TimerDefinition
    
    init(definition: TimerDefinition) {
        self.definition = definition
        self.counter = definition.preparation
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 16))
                .foregroundStyle(.tertiary)
                .overlay {
                    // Foreground ring
                    Circle()
                        .trim(from: 0, to: drawingStroke ? 1 : 0)
                        .stroke(color.gradient,
                                style: StrokeStyle(lineWidth: 16, lineCap: .round))
                }
                .rotationEffect(.degrees(-90))
            
            Text(String(counter))
                .font(.system(size: 108))
                .onReceive(timer) { _ in
                    timerEvent()
                }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .animation(animation, value: drawingStroke)
        .onAppear {
            createAnimation()
            drawingStroke.toggle()
        }
    }
    
    private func timerEvent() {
        countDown()
        if isEnd() {
            end()
        }
    }
    
    private func createAnimation() {
        animation = Animation
            .linear(duration: Double(definition.preparation))
    }
    
    private func end() {
        timer.upstream.connect().cancel()
        drawingStroke.toggle()
        navigationPath.toTimer(definition: definition)
    }
    
    private func isEnd() -> Bool {
        return counter <= 0
    }
    
    private func countDown() {
        counter -= 1
    }
    
}

struct PreparationView_Previews: PreviewProvider {
    static var previews: some View {
        let def = TimerDefinition(preparation: 5, workout: 10, pause: 10, rounds: 3)
        PreparationView(definition: def)
            .environmentObject(NavigationPath())
    }
}
