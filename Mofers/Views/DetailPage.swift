//
//  DetailPage.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct DetailPage: View {
    
    @State var isSelected: Bool = true
    var categoryData: ResultValue

    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .leading) {
                
                HeaderView(width: bounds.size.width)
                    .frame(height: bounds.size.width > breakPoint ? 50 : 10)
                    .padding(.top, 45)
                
                ScrollView {
                    ImageView(width: bounds.size, data: categoryData)
                    
                    DetailsTextsView(size: bounds.size, data: categoryData)
                    
                    SelectionView(size: bounds.size, isSelected: $isSelected)
                    
                    if isSelected {
                        IsDetail(width: bounds.size.width)
                        
                    } else {
                        RatingSection()
                    }
                    
                }
                .padding(.vertical, 20)
                .navigationBarHidden(true)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }

    struct IsLine: View {

        var width: CGFloat

        var body: some View {
            Rectangle()
                .foregroundColor(Color(hex: 0x49425E))
                .frame(width: width > breakPoint ? 80 : 60, height: width > breakPoint ? 8 : 5)
        }
    }

    struct IsDetail: View {

        var width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(translate(key: "highlighted"))
                    .font(.system(size: width / 30,weight: .bold))
                    .padding(.leading, 18)
                ExpentionTile(description: translate(key: "highlightedSubTitle"), width: width)
                    .padding(.bottom, 10)
                VStack(alignment: .leading, spacing: 10) {
                    Text(translate(key: "conditions"))
                        .font(.system(size: width / 30,weight: .bold))
                        .padding(.leading, 18)
                    ExpentionTile(description: translate(key: "conditionSubTitle1"), width: width)
                    ExpentionTile(description: translate(key: "conditionSubTitle1"), width: width)
                    ExpentionTile(description: translate(key: "conditionSubTitle1"), width: width)
                    ExpentionTile(description: translate(key: "conditionSubTitle1"), width: width)
                    Divider()
                        .padding(.vertical, 20)
                    Text(translate(key: "noticeTitle"))
                        .font(.system(size: width / 30, weight: .semibold))
                    +
                    Text(translate(key: "noticeSubTitle"))
                        .foregroundColor(.gray)
                        .font(.system(size: width / 35, weight: .regular))
                }
            }
        }
    }

    struct ImageView: View {

        var width: CGSize
        var data: ResultValue

        var body: some View {

            VStack
            {
                AsyncImage(url: URL(string: data.images?["0"]?.full.url ?? "")) { image in
                    // This closure is called when the image is successfully loaded
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: width.width > breakPoint ? 650 : 250)
    //                    .frame(maxWidth: width * 0.95)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(20)
                }

                HStack {
                    Text(translate(key: "detailCardRealPrice"))
                        .strikethrough(true, color: .red)
                        .foregroundColor(.gray)
                        .font(.system(size: width.width > breakPoint ? 20 : 10, weight: .bold))
                    Text(translate(key: "detailCardDiscount"))
                        .font(.system(size: width.width > breakPoint ? 23 : 13, weight: .bold))
                    Spacer()
                }
            }
        }
    }

    struct DetailsTextsView: View {

        var size: CGSize
        var data: ResultValue

        var body: some View {
            HStack(spacing: 1) {
                VStack(alignment: .leading, spacing: 5) {

                    Text(data.name ?? "")
                        .font(.system(size: size.width > breakPoint ? 30 : 20, weight: .bold))
                        .lineLimit(1)
                    Text(data.distance ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: size.width > breakPoint ? 22 : 12, weight: .bold))
                        .lineLimit(1)
                    Text(data.detail ?? "")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .font(.system(size: size.width > breakPoint ? 19 : 9, weight: .bold))
                        .lineLimit(1)
                    HStack(spacing: 2) {
                        Text("15,78")
                        Image(systemName: "eye")
                            .font(.system(size: size.width > breakPoint ? 20 : 10))
                    }
                    .padding(7)
                    .border(Color.black, width:2)
                    .cornerRadius(7)
                }
    //            .frame(width: size.width * 0.6)
                Spacer()
                CustomStar(isFill: true, width: size.width)
                CustomStar(isFill: true, width: size.width)
                CustomStar(isFill: true, width: size.width)
                CustomStar(width: size.width)
                CustomStar(width: size.width)

                ZStack {
                    Text("8.5")
                        .foregroundColor(.white)
                        .font(.system(size: size.width > breakPoint ? 30 : 10))
                        .frame(width: size.width * 0.09, height: size.height * 0.07)
                }
                .frame(width: size.width > breakPoint ? size.width * 0.1 : size.width * 0.06, height: size.height > breakPoint ? size.height * 0.05 : size.height * 0.03)
                .background(.black)
                .cornerRadius(4)
                .opacity(0.7)
            }
        }
    }

    struct SelectionView: View {

        var size: CGSize

        @Binding var isSelected: Bool

        var body: some View {
            HStack {
                Button {
                    self.isSelected = true
                } label: {
                    SelectionButtonView(
                        size: size,
                        textKey: "details",
                        isSelected: isSelected)
                }

                Spacer()
                Button {
                    self.isSelected = false
                } label: {

                    SelectionButtonView(
                        size: size,
                        textKey: "rating",
                        isSelected: !isSelected)
                }
            }
            .padding(.top, size.width > breakPoint ? 10 : 0)
            .padding(.horizontal, 40)
            .frame(height: size.height * 0.06)
            .background(Color(hex: 0xC7C7C7))
        }
    }

    struct SelectionButtonView: View {

        var size: CGSize
        var textKey: LocalizedStringKey
        var isSelected: Bool

        var body: some View {
            VStack {
                Text(translate(key: textKey))
                    .foregroundColor(isSelected ? Color.black : Color(hex: 0x716F6F))
                    .font(.system(size: size.width > breakPoint ? 27 : 17, weight: .semibold))
                Spacer()

                if isSelected {
                    IsLine(width: size.width)
                        .opacity(isSelected ? 1 : 0)
                }
            }
            .padding(.top, 5)
        }
    }
}













