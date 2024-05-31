//
//  ChangePasswordScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct ChangePasswordScreen: View {
    
    @State private var fullNameText = ""
    @State private var emailText = ""
    @State private var phoneText = ""
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 15) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "changePassword"))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                CustomTextFeild(title: translate(key: "oldPassword"), width: .infinity, controller: $fullNameText, titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "newPassword"), width: .infinity,controller: $emailText, titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "confirmPassword"), width: .infinity,controller: $phoneText
                                , titleWidth: bounds.size.width)
                Spacer()
                saveChangesButton(bounds: bounds)
            }
            .navigationBarHidden(true)
        }
    }

    func saveChangesButton(bounds: GeometryProxy) -> some View {
        Button {
            print(fullNameText)
            print(emailText)
            print(phoneText)
        } label: {
            ZStack {
                Text(translate(key: "saveChanges"))
                    .foregroundColor(.white)
                    .font(.system(size: bounds.size.width > breakPoint ? 26 : 16, weight: .semibold))
            }
            .frame(width: bounds.size.width * 0.97, height: bounds.size.width > breakPoint ? 80 : 50)
            .background(Color(hex: 0x49405F))
            .cornerRadius(10)
        }
        .buttonStyle(NoAnim())
    }

}

struct ChangePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordScreen()
    }
}
