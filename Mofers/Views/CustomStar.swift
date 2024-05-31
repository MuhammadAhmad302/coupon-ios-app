//
//  CustomStar.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct CustomStar: View {

    var isFill: Bool = false
    var width: CGFloat

    var body: some View {
        Image(systemName: !isFill ? "star" : "star.fill")
            .font(.system(size: width / 30))
            .foregroundColor(.orange)
    }
}

struct CustomStar_Previews: PreviewProvider {
    static var previews: some View {
        CustomStar(width: 500)
    }
}
