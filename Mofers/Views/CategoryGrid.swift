//
//  CategoryGrid.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-02.
//

import SwiftUI

struct CategoryGrid: View {
    
    
    struct demoData {
        let image: String
        let categoryName: LocalizedStringKey
    }
    
    var categoryData: [demoData] = [
        demoData(image: "category7", categoryName: translate(key: "meat")),
        demoData(image: "category6", categoryName: translate(key: "coffee")),
        demoData(image: "category4", categoryName: translate(key: "italian")),
        demoData(image: "category2", categoryName: translate(key: "breakFast")),
        demoData(image: "category1", categoryName: translate(key: "bakery")),
        demoData(image: "BG-30", categoryName: translate(key: "american")),
        demoData(image: "category5", categoryName: translate(key: "bbq")),
        demoData(image: "BG-21", categoryName: translate(key: "saudi")),
        demoData(image: "category1", categoryName: translate(key: "partyBox")),
        demoData(image: "category10", categoryName: translate(key: "burgers")),
        demoData(image: "category4", categoryName: translate(key: "healtyFood")),
        demoData(image: "category3", categoryName: translate(key: "sandwiched")),
        demoData(image: "category9", categoryName: translate(key: "asian")),
        demoData(image: "category8", categoryName: translate(key: "international")),
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { bounds in
                VStack {
                    CustomNavigationView(width: bounds.size.width, icon: "arrow.backward", title: "categories", isRoot: true)
                        .padding(.bottom,20)
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: bounds.size.width > breakPoint ? 350 : 120), spacing: 20)], spacing: 15) {
                            ForEach(0..<categoryData.count, id: \.self) { item in
                                NavigationLink(destination: CardsPage(isFill: false, isResturent: false, foodStreet: "Street Food", Cafe: "Cafe")) {
                                    CatagorySection( width: bounds.size.width, image: categoryData[item].image, categoryName: categoryData[item].categoryName, isGradient: true)
                                        .frame(width: bounds.size.width * 0.45 ,height: bounds.size.width > breakPoint ? bounds.size.width * 0.18 : bounds.size.height * 0.13)
                                        .cornerRadius(10)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct CategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGrid()
    }
}
