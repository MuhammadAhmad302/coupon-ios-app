//
//  CatagorySection.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct CatagorySection: View {

    var width: CGFloat
    var image: String
    var categoryName: LocalizedStringKey = ""
    var title: LocalizedStringKey = ""
    var btnText: LocalizedStringKey = ""
    var xOffSet: CGFloat = 0
    var color: Color = .white.opacity(0)
    var isGradient: Bool = false

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            isGradient ? Image("GradientView").resizable() : Image("")
            Text(categoryName)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.system(size: width / 25, weight: .heavy))
            HStack {
                VStack {
                    Text(title)
                        .font(.system(size: width / 25, weight: .semibold))
                    Button {

                    } label: {
                        PrimaryButton(btnWidth: width / 4, btnText: btnText, color: color, width: width, height: width / 25)
                            .cornerRadius(15)
                    }
                }
                .offset(x: xOffSet)
                Spacer()
            }
            .padding(.leading, 20)
        }
    }
}

struct CatagorySection_Previews: PreviewProvider {
    static var previews: some View {
        CatagorySection(width: 20, image: "SliderImage3", categoryName: "Cafe", color: .blue)
    }
}
