//
//  AddLocationScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-09.
//

import SwiftUI

struct AddLocationScreen: View {

    func topArrowView(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            ZStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: bounds.size.width > breakPoint ? 35 : 20))
            }
            .frame(width: bounds.size.width > breakPoint ? 80 : 50, height: bounds.size.width > breakPoint ? 80 : 50)
            .background(.white)
            .cornerRadius(10)
        }
        .shadow(color: Color.gray.opacity(0.3), radius: 5)
        .buttonStyle(NoAnim())
    }

    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .leading, spacing: 25) {
                topArrowView(bounds: bounds)
                Text(translate(key: "findNearRestaurant"))
                    .font(.system(size: bounds.size.width > breakPoint ? 35 : 24, weight: .bold))
                Text(translate(key: "findNearRestaurantDisc"))
                    .font(.system(size: bounds.size.width > breakPoint ? 30 : 18, weight: .medium))
                NavigationLink(destination: MapScreen()) {
                    CustomButton(icon: "currentLocationIcon", title: translate(key: "useCurrentLocation"), width: bounds.size.width, isBorder: true)
                }
                NavigationLink(destination: MapScreen()) {
                    CustomButton(icon: "locationIcon", title: translate(key: "enterNewAddress"), width: bounds.size.width, isColor: true)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}

struct AddLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationScreen()
    }
}

struct CustomButton: View {

    var icon: String
    var title: LocalizedStringKey
    var width: CGFloat
    var isBorder: Bool = false
    var isColor: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            Image(icon)
                .resizable()
                .frame(width: width / 20, height: width / 20)
            Text(title)
                .font(.system(size: width / 30))
        }
        .frame(height: width / 7)
        .frame(minWidth: 0, maxWidth: .infinity)
        .border(isBorder ? Color.black : Color.white, width: 2)
        .background(isColor ? Color(.secondarySystemBackground) : Color.white)        .cornerRadius(5)
    }
}
