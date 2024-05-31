//
//  ExpentionTile.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct ExpentionTile: View {

    var description: LocalizedStringKey
    var width: CGFloat

    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                Image(systemName: "chevron.forward")
                    .font(.system(size: width / 30))
                    .foregroundColor(Color(hex: 0x6F10A2))
                Text(description)
                    .font(.system(size: width / 35))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct ExpentionTile_Previews: PreviewProvider {
    static var previews: some View {
        ExpentionTile(description: "Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!Hello, World! Hello, World! Hello, World!Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!Hello, World! Hello, World! Hello, World!Hello, World!", width: 500)
    }
}
