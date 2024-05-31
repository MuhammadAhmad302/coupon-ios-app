//
//  BottomImageView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct BottomImageView: View {
    
    var width: CGFloat
    
    var body: some View {
        ZStack {
            Image("DayOfDealImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            Text(translate(key: "dealsTagLine"))
                .foregroundColor(.white)
                .font(.system(size: width / 15, weight: .bold))
        }
        .cornerRadius(10)
    }
}

struct BottomImageView_Previews: PreviewProvider {
    static var previews: some View {
        BottomImageView(width: 50)
    }
}
