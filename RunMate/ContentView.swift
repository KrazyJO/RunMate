//
//  ContentView.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Distance: 2.4km").normal()
                Text("fast").normal()
                Text("09:30").large()
                Text("Round 1 of 4").normal()
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                ZStack {
                    HStack {
                        Spacer()
                        Button {
                            print("backward")
                        } label: {
                            Image(systemName: "backward.circle.fill")
                                .font(.system(size: 78))
                        }
                        Spacer()
                        Button {
                            print("play / pause")
                        } label: {
                            Image(systemName: "playpause.circle.fill").font(.system(size: 78))
                        }
                        Spacer()
                        Button {
                            print("forward")
                        } label: {
                            Image(systemName: "forward.circle.fill")
                                .font(.system(size: 78))
                        }
                        Spacer()
                    }
                    .padding()
                }
                Text("distance: 2,4km").normal()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
