//
//  SuggestScrenn.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-04.
//

import SwiftUI

struct SuggestScreen: View {
    
    @State private var subject = ""
    @State private var details = ""
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 15) {
                CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: translate(key: "suggest"))
                    .padding(.bottom, 20)
                    .padding(.horizontal, 10)
                CustomTextFeild(title: translate(key: "suggestSubject"), width: .infinity, controller: $subject, titleWidth: bounds.size.width)
                CustomTextFeild(title: translate(key: "suggestDetails"), width: .infinity, controller: $details, titleWidth: bounds.size.width)
                    .lineLimit(10)
                Spacer()
                suggestSendBtn(bounds: bounds)
            }
            .navigationBarHidden(true)
        }
    }

    func suggestSendBtn(bounds: GeometryProxy) -> some View {
        Button {
            print(subject)
            print(details)
        } label: {
            ZStack {
                Text(translate(key: "send"))
                    .foregroundColor(.white)
                    .font(.system(size: bounds.size.width > breakPoint ? 26 : 16, weight: .semibold))
            }
            .frame(width: bounds.size.width * 0.97, height: bounds.size.width > breakPoint ? 80 : 50)
            .background(Color(hex: 0x49405F))
            .cornerRadius(10)
        }
        .buttonStyle(NoAnim())
        .navigationBarItems(trailing: EmptyView())
        .navigationBarBackButtonHidden(true)
    }

}

struct SuggestScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuggestScreen()
    }
}
