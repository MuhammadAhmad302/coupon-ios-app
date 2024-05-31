//
//  UserInterestPage.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-09.
//

import SwiftUI

struct UserInterestPage: View {
    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Text(translate(key: "whatYouLike"))
                    .font(.system(size: bounds.size.width > breakPoint ? 30 : 15, weight: .medium))
                HStack {
                    CustomTextBlock(text: translate(key: "restaurant"), width: bounds.size.width)
                    CustomTextBlock(text: translate(key: "cafe"), width: bounds.size.width)
                    CustomTextBlock(text: translate(key: "driveThrough"), width: bounds.size.width)
                }
                FoodCategory(width: bounds.size.width)
                UserContactUs(width: bounds.size.width)
                Spacer()
                doneButton(bounds: bounds)
            }
            .padding(.horizontal, 10)
        }
    }

    func doneButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            NavigationLink(destination: AddLocationScreen()) {
                PrimaryButton(btnWidth: .infinity, btnText: translate(key: "done"), color: Color(hex: 0x49425E), width: bounds.size.width)
            }
        }
        .buttonStyle(NoAnim())
    }

    struct FoodCategory: View {

        var width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(translate(key: "foodType"))
                    .font(.system(size: width / 35, weight: .medium))
                HStack {
                    CustomTextBlock(text: translate(key: "meat"), width: width)
                    CustomTextBlock(text: translate(key: "italian"), width: width)
                    CustomTextBlock(text: translate(key: "burgers"), width: width)
                }
                HStack {
                    CustomTextBlock(text: translate(key: "bbq"), width: width)
                    CustomTextBlock(text: translate(key: "breakFast"), width: width)
                    CustomTextBlock(text: translate(key: "healtyFood"), width: width)
                }
                HStack {
                    CustomTextBlock(text: translate(key: "asian"), width: width)
                    CustomTextBlock(text: translate(key: "american"), width: width)
                    CustomTextBlock(text: translate(key: "international"), width: width)
                }
                HStack {
                    CustomTextBlock(text: translate(key: "sandwiched"), width: width)
                    CustomTextBlock(text: translate(key: "saudi"), width: width)
                    CustomTextBlock(text: translate(key: "bakery"), width: width)
                }
            }
        }
    }

    struct UserContactUs: View {

        var width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(translate(key: "userConnect"))
                    .font(.system(size: width / 35, weight: .medium))
                HStack {
                    CustomTextBlock(text: translate(key: "twitter"), width: width)
                    CustomTextBlock(text: translate(key: "whatsapp"), width: width)
                    CustomTextBlock(text: translate(key: "snapShat"), width: width)
                }
                HStack {
                    CustomTextBlock(text: translate(key: "instagram"), width: width)
                    CustomTextBlock(text: translate(key: "onDoor"), width: width)
                    CustomTextBlock(text: translate(key: "other"), width: width)
                }
            }
        }
    }

    struct CustomTextBlock: View {

        var text: LocalizedStringKey
        var width: CGFloat

        var body: some View {
            Text(text)
                .font(.system(size: width / 30, weight: .medium))
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: width / 10)
                .background(Color(hex: 0xC6C6C6))
                .cornerRadius(10)
        }
    }

}

struct UserInterestPage_Previews: PreviewProvider {
    static var previews: some View {
        UserInterestPage()
    }
}
