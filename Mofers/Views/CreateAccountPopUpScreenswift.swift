//
//  CreateAccountPopUpScreenswift.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI
import Firebase

struct CreateAccountPopUpScreenswift: View {
    
    var body: some View {
        GeometryReader { bounds in
            VStack {
                Spacer()
                popupBody(bounds: bounds)
                Spacer()
                successButton(bounds: bounds)
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 10)
        }
    }

    func popupBody(bounds: GeometryProxy) -> some View {
        VStack(spacing: 20) {
            Text(translate(key: "successAcountTitle"))
                .foregroundColor(Color(hex: 0xFAF9F7))
                .font(.system(size: bounds.size.width > breakPoint ? 28 : 18, weight: .medium))
            Text(translate(key: "requestTitle"))
                .foregroundColor(Color(hex: 0xFAF9F7))
                .font(.system(size: bounds.size.width > breakPoint ? 55 : 42, weight: .semibold))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: bounds.size.width > breakPoint ? 350 : 250)
        .background(Color(hex: 0x49425E))
        .cornerRadius(20)

    }

    func successButton(bounds: GeometryProxy) -> some View {
        Button {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: CustomTabView())
        } label: {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "done"), color: Color(hex: 0x49425E), width: bounds.size.width, height: bounds.size.height / 15)
        }
        .shadow(color: Color(hex: 0xEADCF1), radius: 20)
        .buttonStyle(NoAnim())
    }

}
