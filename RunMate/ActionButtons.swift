//
//  ActionButtons.swift
//  RunMate
//
//  Created by Jörn Otte on 25.02.23.
//

import SwiftUI

enum ActionsTypes {
    case backward
    case playPause
    case forward
}

struct ActionButtons: View {
    
    private let forwardAction: (() -> Void)?
    private let backwardAction: (() -> Void)?
    private let playPauseAction: (() -> Void)?

    private var playPauseButtonIcon: Icons
    
    init(playPauseIcon: Icons, forwardAction: ( () -> Void)? = nil, backwardAction: ( () -> Void)? = nil, playPauseAction: ( () -> Void)? = nil) {
        self.playPauseButtonIcon = playPauseIcon
        self.forwardAction = forwardAction
        self.backwardAction = backwardAction
        self.playPauseAction = playPauseAction
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                doAction(type: .backward)
            } label: {
                Image(systemName: Icons.backward.rawValue)
                    .font(.system(size: 78))
            }
            Spacer()
            Button {
                doAction(type: .playPause)
            } label: {
                Image(systemName: playPauseButtonIcon.rawValue).font(.system(size: 78))
            }
            Spacer()
            Button {
                doAction(type: .forward)
            } label: {
                Image(systemName: Icons.forward.rawValue)
                    .font(.system(size: 78))
            }
            Spacer()
        }
    }

    private func doAction(type: ActionsTypes) {
        switch type {
        case .forward:
            forwardAction?()
        case .playPause:
            playPauseAction?()
        case .backward:
            backwardAction?()
        }
    }
}

struct ActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtons(playPauseIcon: Icons.play)
    }
}
