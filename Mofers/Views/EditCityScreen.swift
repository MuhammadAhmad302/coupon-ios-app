//
//  EditCityScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-04.
//

import SwiftUI

struct EditCityScreen: View {

    var cityName = [translate(key: "amman"), translate(key: "zarqa"), translate(key: "irbid"), translate(key: "russeifa"), translate(key: "sahab")]

    var body: some View {
        ScrollView {
            GeometryReader { bounds in
                VStack(spacing: 25) {
                    ForEach(0..<5, id: \.self) { item in
                        Button {

                        } label: {
                            ZStack {
                                Text(cityName[item])
                                    .foregroundColor(Color(hex: 0x49425E))
                                    .font(.system(size: bounds.size.width > breakPoint ? 26 : 16, weight: .semibold))
                                    .frame(height: bounds.size.width > breakPoint ? 80 : 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: 0xEDEAF5))
                                    .cornerRadius(10)
                            }
                        }
                        .buttonStyle(NoAnim())
                    }
                }
                .padding(.vertical, 50)
            }
        }
    }
}

struct EditCityScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditCityScreen()
    }
}
