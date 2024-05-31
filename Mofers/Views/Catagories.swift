//
//  Catagories.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI

struct Catagories: View {

    var width: CGFloat
    let categories = [("CategoryCafe", "cafe"), ("CategoryRestaurant", "restaurant"), ("CategoryFoodStreet", "streetFood")]
    @ObservedObject var categoryData = OfferBannerViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(translate(key: "categories"))
                .font(.system(size: width / 20 , weight: .bold))
            HStack {
                ForEach(categories, id: \.0) { category in
                    switch category.0 {
                    case "CategoryCafe":
                        cafeNavigationLink()
                    case "CategoryRestaurant":
                        restaurantNavigationLink()
                    case "CategoryFoodStreet":
                        streetFoodNavigationLink()
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
            }
        }
    }

    func cafeNavigationLink() -> some View {
        NavigationLink(destination: CardsPage(isFill: false, isResturent: true, Cafe: "Cafe")) {
            CatagorySection(width: width ,image: "CategoryCafe", categoryName: translate(key: "cafe"))
                .frame(width: width > breakPoint ? width / 3.15 : width / 3.3,height: width > breakPoint ? width / 3.15 : width / 3.3)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }

    func restaurantNavigationLink() -> some View {
        NavigationLink(destination: RestaurantList(isResturent: true, restuarent: "Restaurants")) {
            CatagorySection(width: width, image: "CategoryRestaurant", categoryName: translate(key: "restaurant"))
                .frame(width: width > breakPoint ? width / 3.15 : width / 3.3,height: width > breakPoint ? width / 3.15 : width / 3.3)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }

    func streetFoodNavigationLink() -> some View {
        NavigationLink(destination: CardsPage(isFill: false, isResturent: true, Cafe: "Street Food")) {
            CatagorySection(width: width ,image: "CategoryFoodStreet", categoryName: translate(key: "streetFood"))
                .frame(width: width > breakPoint ? width / 3.15 : width / 3.3,height: width > breakPoint ? width / 3.15 : width / 3.3)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }

    func categorySection(image: String, categoryName: String) -> some View {
        CatagorySection(width: width, image: image, categoryName: translate(key: "categoryName"))
            .frame(width: width > breakPoint ? width / 3.15 : width / 3.3, height: width > breakPoint ? width / 3.15 : width / 3.3)
            .cornerRadius(10)
    }

}

struct Catagories_Previews: PreviewProvider {
    static var previews: some View {
        Catagories(width: 500)
    }
}
