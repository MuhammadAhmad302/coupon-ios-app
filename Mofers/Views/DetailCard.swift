//
//  DetailCard.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI
import Firebase

struct DetailCard: View {

    var controller: Bool = false
    @State var showPopUP: Bool = false
    var size: CGSize
    var category: ResultValue
    @AppStorage("log_State") var log_State = false
    @State var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading) {
            imageView(bounds: size)
            titleSection(bounds: size)
            detailSection(bounds: size)
            Text(translate(key: "detailCardSubTitle"))
                .foregroundColor(.gray)
                .font(.system(size: size.width > breakPoint ? 22 : 12, weight: .bold))
            buttonSection(bounds: size)
        }
        .padding(.horizontal, 10)
        .frame(width: size.width, height: size.height)
    }

    func imageView(bounds: CGSize) -> some View {
        AsyncImage(url: URL(string: category.images?["0"]?.full.url ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: size.width > breakPoint ? 800 : 330)
                .frame(width: size.width > breakPoint ? size.width * 0.98 : size.width * 0.95)
                .clipped()
                .cornerRadius(10)
                .overlay (
                    Button(action: {
                        // Toggle bookmark status on click
                        isBookmarked.toggle()
                    }) {
                        ZStack {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .font(.system(size: size.width > breakPoint ? 35 : 15))
                        }
                        .frame(width: size.width > breakPoint ? 60 : 30, height: size.width > breakPoint ? 60 : 30)
                        .background(.white)
                        .cornerRadius(10)
                    }
                        .buttonStyle(NoAnim())
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    , alignment: .topLeading
                )
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: size.width > breakPoint ? 800 : 330)
                .frame(width: size.width > breakPoint ? size.width * 0.98 : size.width * 0.95)
                .clipped()
                .cornerRadius(20)
        }
    }

    func titleSection(bounds: CGSize) -> some View {
        return
        HStack(alignment: .center, spacing: 2) {
            Text(category.name ?? "")
                .strikethrough(true, color: .red)
                .foregroundColor(.gray)
                .font(.system(size: size.width > breakPoint ? 20 : 10, weight: .bold))
            Text(category.category_name ?? "")
                .font(.system(size: size.width > breakPoint ? 23 : 13, weight: .bold))
        }
    }

    func viewSection(bounds: CGSize) -> some View {
        HStack {
            Image(systemName: "eye")
                .font(.system(size: size.width > breakPoint ? 30 : 15))
            Text("15,78")
                .font(.system(size: size.width > breakPoint ? 23 : 13, weight: .bold))
        }
    }

    func shareSection(bounds: CGSize) -> some View {
        HStack {
            Image(systemName: "arrowshape.turn.up.right.fill")
                .foregroundColor(Color(hex: 0x6F10A2))
                .font(.system(size: size.width > breakPoint ? 30 : 20))
            Text("690")
                .font(.system(size: size.width > breakPoint ? 23 : 13, weight: .bold))
        }
    }

    func buttonSection(bounds: CGSize) -> some View {
        HStack {
            SecondaryButton(btnWidth: size.width * 0.4, btnText: translate(key: "share"), color: .red, width: size.width, height: size.height / 10)
            Spacer()
            if Auth.auth().currentUser != nil {
                NavigationLink(destination: DetailPage(categoryData: category)) {
                    PrimaryButton(btnWidth: size.width * 0.6, btnText: translate(key: "more"), color: Color(hex: 0x6B5D96), width: size.width, height: size.height / 10)
                }
            } else {
                NavigationLink(destination: LoginScreen()) {
                    PrimaryButton(btnWidth: size.width * 0.6, btnText: translate(key: "more"), color: Color(hex: 0x6B5D96), width: size.width, height: size.height / 10)
                }
            }
        }
    }

    func detailSection(bounds: CGSize) -> some View {
        HStack(alignment: .top) {
            Text(category.status ?? "")
                .font(.system(size: size.width > breakPoint ? 30 : 20, weight: .bold))
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                viewSection(bounds: size)
                shareSection(bounds: size)
            }
        }.padding(.top, 1)
    }

}
