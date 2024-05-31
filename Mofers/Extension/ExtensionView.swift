//
//  ExtensionView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-04-04.
//

import Foundation
import SwiftUI

extension View {

    func getRootViewController() -> UIViewController {

        guard let screen = UIApplication.shared.connectedScenes.first as?  UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
