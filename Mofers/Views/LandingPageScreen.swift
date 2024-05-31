//
//  LandingPageScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-06.
//

import SwiftUI

struct LandingPageScreen: View {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        ZStack {
            Color(hex: 0x101010).opacity(0.8).ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .leading) {
                    Button {
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
                    } label: {
                        Text("X")
                            .foregroundColor(Color(hex: 0xCCC4C4))
                            .font(.system(size: screenWidth / 15, weight: .regular))
                    }
                    .buttonStyle(NoAnim())
                    ZStack {
                        Image("Restaurant")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screenWidth * 0.8 ,height: screenWidth * 0.8)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct LandingPageScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageScreen()
    }
}

