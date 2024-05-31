//
//  RestaurantList.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-09.
//

import SwiftUI

struct RestaurantList: View {

    var isResturent: Bool
    var restuarent: String
    @State var searchText = ""
    @StateObject var viewModel = CategoryViewModel()

    var body: some View {
        GeometryReader { bounds in
            VStack {
                HeaderView(width: bounds.size.width)
                    .padding(.top, 40)
                CustomSearchFeild(controller: isResturent, width: bounds.size.width, searchText: $searchText)
                if viewModel.restuarent.isEmpty {
                    ProgressView()
                        .onAppear {
                            viewModel.fetchAllCategories()
                        }
                } else {
                    ScrollView {
                        ForEach(viewModel.restuarent.indices, id: \.self) { item in
                            if(viewModel.restuarent[item].category_name == restuarent){
                                RestaurantCell(width: bounds.size.width, category: viewModel.restuarent[item])
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .navigationBarHidden(true)
            .searchable(text: $searchText)
        }
    }

    var filteredRestaurants: [ResultValue] {
        if searchText.isEmpty {
            return viewModel.restuarent
        } else {
            if restuarent == "Restaurants" {
                return viewModel.restuarent.filter { $0.category_name == "Restaurants" && $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
            } else {
                return viewModel.restuarent
            }
        }
    }

    struct RestaurantCell: View {

        var width: CGFloat
        var category: ResultValue

        var body: some View {
            HStack(alignment: .center, spacing: 10) {
                imageView()
                detailSection()
            }
        }

        func imageView() -> some View {
            AsyncImage(url: URL(string: category.images?["0"]?.full.url ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 5, height: width / 5)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay (
                            ZStack {
                                Image(systemName: "bookmark")
                                    .font(.system(size: width / 35))
                            }
                                .frame(width: width / 22, height: width / 22)
                                .background(.white)
                                .cornerRadius(5)
                                .padding(.top, 7)
                                .padding(.leading, 5)
                            , alignment: .topLeading
                        )
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 5, height: width / 5)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                @unknown default:
                    EmptyView()
                }
            }
        }

        func detailSection() -> some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(category.name ?? "")
                    .font(.system(size: width / 30, weight: .medium))
                Text(category.category_name ?? "")
                    .font(.system(size: width / 35, weight: .regular))
                Text(category.cityName ?? "")
                    .font(.system(size: width / 35, weight: .regular))
                Text(category.address ?? "")
                    .font(.system(size: width / 35, weight: .regular))
                HStack(spacing: 0) {
                    Spacer()
                    CustomStar(isFill: true, width: width)
                    CustomStar(isFill: true, width: width)
                    CustomStar(isFill: true, width: width)
                    CustomStar(width: width)
                    CustomStar(width: width)
                }
                .padding(.trailing, 10)
            }
        }

    }
}
