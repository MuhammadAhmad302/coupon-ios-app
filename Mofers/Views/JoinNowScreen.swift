//
//  JoinNowScreen.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-08.
//

import SwiftUI

struct JoinNowScreen: View {
    
    @State var fullName = ""
    @State var emailAddress = ""
    @State var phoneNumber = ""
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 50) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: "Join now")
                VStack(spacing: 20) {
                    CustomTextFeild(title: "Full Name", width: .infinity, controller: $fullName, titleWidth: bounds.size.width)
                    CustomTextFeild(title: "Email Address", width: .infinity, controller: $emailAddress, titleWidth: bounds.size.width)
                    CustomTextFeild(title: "Phone Number", width: .infinity, controller: $phoneNumber, icon: "iphone.gen2", titleWidth: bounds.size.width)
                    Spacer()
                    PrimaryButton(btnWidth: .infinity, btnText: "Send", color: Color(hex: 0x6B5D96), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct JoinNowScreen_Previews: PreviewProvider {
    static var previews: some View {
        JoinNowScreen()
    }
}
