//
//  CustomSecureFeild.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-11.
//

import SwiftUI

struct CustomSecureFeild: View {
    
    var title: LocalizedStringKey
    var width: CGFloat
    var height: CGFloat? = 5
    var controller: Binding<String>
    var icon: String?
    var fontSize: CGFloat
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            TextField(title, text: controller)
                .font(.system(size: fontSize / 30))
                .padding(.leading, 15)
                .frame(width: width, height: fontSize / 10)
                .multilineTextAlignment(.leading)
                .keyboardType(keyboardType)
            Image(systemName: icon ?? "")
                .font(.system(size: fontSize / 30))
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}
