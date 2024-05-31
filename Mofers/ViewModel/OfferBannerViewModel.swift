import Foundation

class OfferBannerViewModel: ObservableObject {

    @Published var offers: [OfferBannerResult] = []

    @Published var count = 0

    func fetchAllBannerOffer() {
        HTTPManager.shared.get("https://jomlahway.com/couponapp/smarty/PHP-source/api/1.0/nsbanner/getBanners") { (response: OfferBanner?) in
            if let response = response {
                print(response)
                DispatchQueue.main.async {
                    self.offers = Array(response.result.values)
                }
            }
        }
    }



//    func fetchAllBannerOffer() {
//        let url = URL(string: "https://jomlahway.com/couponapp/smarty/PHP-source/api/1.0/nsbanner/getBanners")
//
//        let task = URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
//            let decoder = JSONDecoder()
//            if let data = data {
//                do {
//                    let response = try decoder.decode(OfferBanner.self, from: data)
////                    print(response)
//                    DispatchQueue.main.async {
//                        if response.result.values != nil {
//                            self?.offers = Array(response.result.values)
//                        }
////                        self.offers = Array(response.result.values)
////                        self.count = 1
//                    }
//                    print(self?.offers)
//                } catch {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
//    }
}
