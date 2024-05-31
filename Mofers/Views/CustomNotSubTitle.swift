//
//  CustomNotSubTitle.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-03.
//

import SwiftUI

struct CustomNotSubTitle: View {
    var width: CGFloat
    var leadingIcon: String
    var title: LocalizedStringKey
    var tralingIcon: String
    var isSuggest: Bool = false
    
    var body: some View {
        HStack(spacing: width < breakPoint ? isSuggest ? 25 : 20 : isSuggest ? 30  : 20) {
            Image(leadingIcon)
                .resizable()
                .frame(width: isSuggest ? width / 23 : width / 15, height: isSuggest ? width / 23 : width / 15)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: width / 30, weight: .regular))
            }
            Spacer()
            Image(systemName: tralingIcon)
                .font(.system(size: width / 30))
                .foregroundColor(.black)
        }
    }
}

struct CustomNotSubTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomNotSubTitle(width: 200, leadingIcon: "faqIcon", title: "Hello Ahmad", tralingIcon: "person")
    }
}
