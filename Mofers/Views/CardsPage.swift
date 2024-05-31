import SwiftUI

struct CardsPage: View {
    var isFill: Bool
    var isResturent: Bool
    var foodStreet: String = ""
    var Cafe: String = ""

    @StateObject var viewModel = CategoryViewModel()
    @State var searchText = ""

    var filteredRestaurants: [ResultValue] {
        if searchText.isEmpty {
            return viewModel.restuarent
        } else {
            if Cafe == "Cafe" {
                return viewModel.restuarent.filter { $0.category_name == "Cafe" && $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
            } else if foodStreet == "Street Food" {
                return viewModel.restuarent.filter { $0.category_name == "Street Food" && $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
            } else {
                return viewModel.restuarent.filter { $0.category_name == "Restaurant" && $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
            }
        }
    }



    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 10) {
                HeaderView(width: bounds.size.width, isRoot: true)
                    .padding(.horizontal, 10)
                    .padding(.top, 40)
                CustomSearchFeild(controller: isResturent, width: bounds.size.width, searchText: $searchText)
                    .padding(.horizontal, 10)

                if viewModel.restuarent.isEmpty {
                    ProgressView()
                        .onAppear {
                            viewModel.fetchAllCategories()
                        }
                } else {
                    ScrollView {
                        SliderImageView(width: bounds.size.width)
                        ForEach(filteredRestaurants.indices, id: \.self) { index in
                            if(viewModel.restuarent[index].category_name == foodStreet || viewModel.restuarent[index].category_name == Cafe) {
                                DetailCard(controller: isFill, size: bounds.size, category: filteredRestaurants[index])
                                    .frame(height: bounds.size.width > breakPoint ? 1100 : 520)
                                    .frame(width: bounds.size.width)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CardsPage_Previews: PreviewProvider {
    static var previews: some View {
        CardsPage(isFill: true, isResturent: false, foodStreet: "", Cafe: "")
    }
}
