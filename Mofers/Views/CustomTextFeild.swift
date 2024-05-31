//
//  CustomTextFeild.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct CustomTextFeild: View {
    
    
    var title: LocalizedStringKey
    var width: CGFloat
    var height: CGFloat? = 50
    var controller: Binding<String>
    var icon: String?
    var titleWidth: CGFloat
    
    
    var body: some View {
        VStack(alignment: .leading) {
            title(bounds: width)
            HStack {
                customTextFeild(bounds: width)
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal, 10)
    }

    func title(bounds: CGFloat) -> some View {
        Text(title)
            .foregroundColor(.gray)
            .font(.system(size: titleWidth / 35, weight: .regular))
    }

    func customTextFeild(bounds: CGFloat) -> some View {
     return TextField("", text: controller)
            .font(.system(size: titleWidth / 30))
            .padding(.leading, 15)
            .frame(width: width, height: titleWidth / 10)
            .multilineTextAlignment(.leading)
        Image(systemName: icon ?? "")
            .font(.system(size: titleWidth / 30))
    }

}
