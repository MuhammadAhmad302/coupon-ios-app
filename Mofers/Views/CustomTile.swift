//
//  CustomTile.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct CustomTile: View {
    var width: CGFloat
    var leadingIcon: String
    var title: LocalizedStringKey
    var subTitle: LocalizedStringKey
    var tralingIcon: String
    var isSuggest: Bool = false

    var body: some View {
        HStack(spacing: isSuggest ? 28 : 20) {

            Image(leadingIcon)
                .resizable()
                .frame(width: isSuggest ? width / 21 : width / 15, height: isSuggest ? width / 21 : width / 15)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: width  / 30, weight: .regular))
                Text(subTitle)
                    .foregroundColor(.gray)
                    .font(.system(size: width / 30, weight: .regular))
            }
            Spacer()
            Image(systemName: tralingIcon)
                .font(.system(size: width / 30))
                .foregroundColor(.black)
        }
    }
}

struct CustomTile_Previews: PreviewProvider {
    static var previews: some View {
        CustomTile(width: 300, leadingIcon: "emailIcon", title: "Hello", subTitle: "My name is Ahmad", tralingIcon: "chevron.forward")
    }
}
