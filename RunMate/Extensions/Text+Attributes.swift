//
//  Text+Attributes.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

extension Text {
    func normal() -> Text {
        return self.font(.system(size: 24))
    }

    func large() -> Text {
        return self.font(.system(size: 78))
    }
}
