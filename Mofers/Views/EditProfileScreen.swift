//
//  EditProfileScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @State private var fullNameText = ""
    @State private var emailText = ""
    @State private var phoneText = ""
    @State private var bioText = ""
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 15) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "editProfile"))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                CustomTextFeild(title: translate(key: "fullName"), width: .infinity, controller: $fullNameText, titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "emailAddress"), width: .infinity,controller: $emailText, titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "phoneNumber"), width: .infinity, controller: $phoneText, icon: "iphone.gen2", titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "bio"), width: .infinity,controller: $bioText, titleWidth: bounds.size.width)
                Spacer()
                saveChangesButton(bounds: bounds)
            }
            .navigationBarHidden(true)
        }
    }

    func saveChangesButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            PrimaryButton(btnWidth: .infinity,btnText: translate(key: "saveChanges"), color: Color(hex: 0x49405F), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
        }
        .padding(.horizontal, 10)
        .buttonStyle(NoAnim())
    }

}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen()
    }
}
