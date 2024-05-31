//
//  SplashScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct SplashScreen: View {

    @State var isActive: Bool = false

    var body: some View {
        GeometryReader { bounds in
            if isActive {
                ContentView()
            } else {
                VStack {
                    Spacer()
                    logoImage(bounds: bounds)
                    Spacer()
                    tagLine(bounds: bounds)
                }
                .padding(.horizontal, 20)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }

    func logoImage(bounds: GeometryProxy) -> some View {
        Image("splashLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: bounds.size.width > breakPoint ? 500 : 300)
            .clipped()
    }

    func tagLine(bounds: GeometryProxy) -> some View {
        Text(translate(key: "splashTagLine"))
            .font(.system(size: bounds.size.width > breakPoint ? 30 : 14, weight: .bold))
    }

}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
