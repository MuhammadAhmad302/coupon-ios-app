//
//  SecondaryButton.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct SecondaryButton: View {
    
    var btnWidth: CGFloat? = 200
    var btnText: LocalizedStringKey
    var color: Color
    var width: CGFloat
    var height: CGFloat?
    
    var body: some View {
        ZStack {
            Text(btnText)
                .foregroundColor(.purple)
                .frame(height: height)
                .frame(maxWidth: btnWidth)
                .font(.system(size: width / 25, weight: .semibold))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: (height! - 2))
                        .frame(maxWidth: btnWidth)
                )
        }
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(btnWidth: 60, btnText: "Share", color: .red, width: 500)
    }
}
