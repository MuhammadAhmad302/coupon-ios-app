//
//  RatingSection.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct RatingSection: View {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        VStack {
            TitleView(screenWidth: screenWidth)
            RatingView(screenWidth: screenWidth)
            ReviewSectionView(screenWidth: screenWidth)
        }
    }
    
    struct ReviewSection: View {
        
        var title: LocalizedStringKey
        var date: LocalizedStringKey
        var discription: LocalizedStringKey
        var width: CGFloat
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(title)
                        .font(.system(size: width / 40, weight: .semibold))
                    Spacer()
                    Text(date)
                        .font(.system(size: width / 45, weight: .semibold))
                }
                Text(discription)
                    .font(.system(size: width / 40, weight: .regular))
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    struct RatingView: View {
        
        var screenWidth: CGFloat
        
        var body: some View {
            HStack {
                VStack {
                    
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag1", ratings: "5.8")
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag2", ratings: "5.8")
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag3", ratings: "5.8")
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag4", ratings: "5.8")
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag5", ratings: "5.8")
                    FlexibleLineView(screenWidth: screenWidth, key: "reviewTag6", ratings: "5.8")
                }
                .frame(height: screenWidth * 0.35)
                
                RatingBoxView(screenWidth: screenWidth)
            }
        }
    }
    
    struct FlexibleLineView: View {
        
        var screenWidth: CGFloat
        var key: LocalizedStringKey
        var ratings: String
        
        var body: some View {
            HStack(spacing: 2) {
                
                Text(translate(key: key))
                    .foregroundColor(Color(hex: 0x49425E))
                    .font(.system(size: screenWidth * 0.03, weight: .semibold))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                
                Rectangle()
                    .fill(.yellow)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 3)
                
                Text(ratings)
                    .font(.system(size: screenWidth  * 0.03))
                
            }
        }
    }
    
    struct RatingBoxView: View {
        
        var screenWidth: CGFloat
        
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(hex: 0x6B5D96))
                    .cornerRadius(screenWidth * 0.0268)
                Text("8.5")
                    .foregroundColor(Color(hex: 0xF5F4F0))
                    .font(.system(size: screenWidth / 15, weight: .semibold))
            }
            .frame(width: screenWidth * 0.35, height: screenWidth * 0.35)
        }
    }
    
    struct TitleView: View {
        
        var screenWidth: CGFloat
        
        var body: some View {
            VStack {
                Text(translate(key: "reviewTitle"))
                    .multilineTextAlignment(.center)
                    .font(.system(size: screenWidth / 40, weight: .semibold))
                    .foregroundColor(Color(hex: 0xF20C27))
            }
            .frame(width: screenWidth / 3)
        }
    }
    
    struct ReviewSectionView: View {
        
        var screenWidth: CGFloat
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 5) {
                    Text(translate(key: "dailyReviews"))
                        .foregroundColor(Color(hex: 0xFC0610))
                        .font(.system(size: screenWidth / 40, weight: .semibold))
                    CustomStar(width: screenWidth)
                    CustomStar(width: screenWidth)
                    CustomStar(width: screenWidth)
                    CustomStar(width: screenWidth)
                    CustomStar(width: screenWidth)
                }
                ReviewSection(title: translate(key: "userReviewTitle"), date: translate(key: "date"), discription: translate(key: "userReviewDiscription"), width: screenWidth)
                Divider()
                ReviewSection(title: translate(key: "userReviewTitle"), date: translate(key: "date"), discription: translate(key: "userReviewDiscription"), width: screenWidth)
                Divider()
                ReviewSection(title: translate(key: "userReviewTitle"), date: translate(key: "date"), discription: translate(key: "userReviewDiscription"), width: screenWidth)
            }
        }
    }
}

struct RatingSection_Previews: PreviewProvider {
    static var previews: some View {
        RatingSection()
    }
}
