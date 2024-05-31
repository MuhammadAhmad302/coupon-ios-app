//
//  Constants.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-10.
//

import Foundation
import SwiftUI

var breakPoint: CGFloat = 500

struct NoAnim: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
