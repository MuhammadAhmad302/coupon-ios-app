//
//  Home.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        NavigationView {
            GeometryReader { bounds in
                ScrollView {
                    CoverImage(width: bounds.size.width)
                    
                    SliderImageView(width: bounds.size.width)
                        .padding(.top, bounds.size.width > breakPoint ? 15 : 5)
                    
                    Catagories(width: bounds.size.width)
                        .padding(.horizontal, 10)
                    
                    BottomImageView(width: bounds.size.width)
                        .padding(.vertical, bounds.size.width > breakPoint ? 10 : 3)
                        .padding(.horizontal, 10)
                    
                    AdvertizementSection(width: bounds.size.width)
                        .padding(.horizontal, 10)
                    
                    NearRestaurants(width: bounds.size.width)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct AdvertizementSection: View {
    
    var width: CGFloat
    
    var body: some View {
        VStack(spacing: width > breakPoint ? 20 : 10) {
            CatagorySection(width: width, image: "offerImage", title: translate(key: "buyOferrs"), btnText: translate(key: "her"), color: Color(hex: 0x49425E))
                .frame(height: width * 0.3)
                .cornerRadius(10)
            HStack(spacing: 10) {
                CatagorySection(width: width ,image: "HighPriceImage", categoryName: translate(key: "heightestRate"))
                    .cornerRadius(10)
                CatagorySection(width: width, image: "Offer_Image", categoryName: translate(key: "offersWeek"))
                    .cornerRadius(10)
            }
            CatagorySection(width: width, image: "inviteImage", title: translate(key: "inviteYou"), btnText: translate(key: "her"), color: Color(hex: 0x49425E))
                .frame(height: width * 0.3)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
        }
    }
}

struct NearRestaurants: View {
    
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(translate(key: "nearRestaurants"))
                .font(.system(size: width / 20))
            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CustomRestaurantCell(width: width)
                        CustomRestaurantCell(width: width)
                        CustomRestaurantCell(width: width)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CustomRestaurantCell(width: width)
                        CustomRestaurantCell(width: width)
                        CustomRestaurantCell(width: width)
                    }
                }
            }
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(5)
        }
        .padding(.horizontal, 10)
    }
}

struct CustomRestaurantCell: View {
    
    var width: CGFloat
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                Image("mcdonal-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width / 7, height: width / 7)
            }
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .frame(width: width / 5, height: width / 5)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(translate(key: "mcDonalds"))
                    .font(.system(size: width / 30, weight: .medium))
                Text(translate(key: "countOffers"))
                    .font(.system(size: width / 35, weight: .regular))
                Text(translate(key: "distance"))
                    .font(.system(size: width / 35, weight: .regular))
            }
            Spacer()
        }
        .padding(.leading, 10)
        .frame(width: width / 1.7, height: width / 3.9)
        .background(.white)
        .cornerRadius(10)
    }
}


