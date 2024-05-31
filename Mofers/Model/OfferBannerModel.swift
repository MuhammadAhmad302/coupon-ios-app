
import Foundation

struct OfferBanner: Codable {
    let success: Int
    let result: [String: OfferBannerResult]
    let args: [String: Int]
}

struct OfferBannerResult: Codable {
    let id: String
    let title: String
    let description: String
    let image: [String: OfferBannerImage]
    let module: String
    let module_id: String
    let status: String
    let date_start: String?
    let date_end: String?
    let is_can_expire: String?
    let updated_at: String
    let created_at: String
}

struct OfferBannerImage: Codable {
    let full: OfferBannerImageSize
    let _560_560: OfferBannerImageSize
    let _200_200: OfferBannerImageSize
    let _100_100: OfferBannerImageSize
    let name: String

    enum CodingKeys: String, CodingKey {
        case full
        case _560_560 = "560_560"
        case _200_200 = "200_200"
        case _100_100 = "100_100"
        case name
    }
}

struct OfferBannerImageSize: Codable {
    let name: String
    let path: String
    let url: String
    let ext: String
}
