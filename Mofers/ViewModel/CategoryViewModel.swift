
import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategoryDataResponse] = []
    @Published var restuarent: [ResultValue] = []
    @Published var filteredRestuarent: [ResultValue] = []
    @Published var searchText = ""
    @Published var isLoading = false

    func fetchAllCategories() {
        HTTPManager.shared.get("https://jomlahway.com/couponapp/smarty/PHP-source/api/1.0/store/getStores") { (response: CategoryDataResponse?) in
            if let response = response {
                print(response)
                DispatchQueue.main.async {
                    self.restuarent = Array(response.result!.values)
                    self.filteredRestuarent = Array(response.result!.values)
                }
            }
        }
    }

//    func fetchAllCategories() {
//        isLoading = true
//        let url = URL(string: "https://jomlahway.com/couponapp/smarty/PHP-source/api/1.0/store/getStores")
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(CategoryDataResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        if let values = response.result?.values {
//                            self.restuarent = Array(values)
//                            self.filteredRestuarent = Array(values)
//                            self.isLoading = false
//                        }
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
//    }

    func searchRestaurants() {
        isLoading = true
        let url = URL(string: "https://jomlahway.com/couponapp/smarty/PHP-source/api/1.0/store/getStores?search=\(searchText)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(CategoryDataResponse.self, from: data)
                    DispatchQueue.main.async {
                        if let values = response.result?.values {
                            self.filteredRestuarent = Array(values)
                            self.isLoading = false
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
