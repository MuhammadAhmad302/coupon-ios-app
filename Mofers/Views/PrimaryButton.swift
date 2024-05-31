//
//  PrimaryButton.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct PrimaryButton: View {
    
    var btnWidth: CGFloat? = 200
    var btnText: LocalizedStringKey
    var color: Color
    var width: CGFloat
    var height: CGFloat?
    
    var body: some View {
        ZStack {
            Text(btnText)
                .foregroundColor(.white)
                .frame(height: height)
                .frame(maxWidth: btnWidth)
                .font(.system(size: width / 25, weight: .semibold))
                .background(color)
                .cornerRadius(8)
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(btnWidth: 50, btnText: "More", color: Color(hex: 0x49425E), width: 500, height: 300)
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double(hex & 0xff) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
