//
//  ReviewPostView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-09.
//

import SwiftUI

struct ReviewPostView: View {

    @State var submitPost = ""

    var body: some View {
        GeometryReader { bounds in
            VStack(alignment: .leading, spacing: 25) {
                backArrowButton(bounds: bounds)
                PostReviewSection(width: bounds.size.width)
                reviewBox(bounds: bounds)
                Spacer()
                postButton(bounds: bounds)
            }
            .padding(.horizontal, 10)
        }
    }

    struct PostReviewSection: View {

        var width: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                Text(translate(key: "dalia"))
                    .font(.system(size: width > breakPoint ? 25 : 14, weight: .semibold))
                VStack(spacing: 5) {
                    postReviewCell(title: "reviewTag1")
                    postReviewCell(title: "reviewTag2")
                    postReviewCell(title: "reviewTag3")
                    postReviewCell(title: "reviewTag4")
                    postReviewCell(title: "reviewTag5")
                    postReviewCell(title: "reviewTag6")
                }
            }
        }

        func postReviewCell(title: LocalizedStringKey) -> some View {
            HStack {
                Text(translate(key: title))
                    .foregroundColor(Color(hex: 0x49425E))
                    .font(.system(size: width / 30, weight: .semibold))
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    CustomStar(width: width)
                    CustomStar(width: width)
                    CustomStar(width: width)
                    CustomStar(width: width)
                    CustomStar(width: width)
                }
            }
        }

    }

    struct PlaceholderTextView: View {
        let placeholder: String
        @Binding var text: String

        var body: some View {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(.placeholderText))
                }
                TextEditor(text: $text)
                    .font(.body)
            }
        }


    }

    func postButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            PrimaryButton(btnWidth: .infinity, btnText: translate(key: "post"), color: Color(hex: 0x6B5D96), width: bounds.size.width, height: bounds.size.width > breakPoint ? 80 : 50)
        }
    }

    func reviewBox(bounds: GeometryProxy) -> some View {
        ZStack {
            TextEditor(text: $submitPost)
                .font(.system(size: bounds.size.width > breakPoint ? 30 : 18))
                .frame(height: bounds.size.width > breakPoint ? 200 : 100)
                .padding(.leading, 10)
                .border(Color.gray, width: 1)
                .foregroundColor(Color(hex: 0x8686861A))
                .cornerRadius(5.0)
                .overlay(
                    Text(submitPost.isEmpty ? translate(key: "userShareExperience") : "")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .opacity(submitPost.isEmpty ? 1 : 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                )
        }
    }

    func backArrowButton(bounds: GeometryProxy) -> some View {
        Button {

        } label: {
            ZStack {
                Image(systemName: "arrow.backward")
                    .foregroundColor(Color(hex: 0x6F10A2))
                    .font(.system(size: bounds.size.width > breakPoint ? 35 : 20))
            }
            .frame(width: bounds.size.width > breakPoint ? 80 : 50, height: bounds.size.width > breakPoint ? 80 : 50)
            .background(.white)
            .cornerRadius(10)
        }
        .shadow(color: Color.gray.opacity(0.3), radius: 5)
        .buttonStyle(NoAnim())
    }

}


struct ReviewPostView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPostView()
    }
}

