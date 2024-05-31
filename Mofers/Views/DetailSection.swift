//
//  DetailSection.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct DetailSection: View {
    var body: some View {
        GeometryReader { bounds in
            ExpentionTile(description: "Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello", width: bounds.size.width)
        }
    }
}

struct DetailSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailSection()
    }
}
