//
//import Foundation
//
//struct CategoryData: Codable {
//    let success: Int
//    let result: [String: StoreInfo]
//}
//
//struct StoreInfo: Codable {
//    let sumRating: Double?
//    let category_color: String
//    let category_name: String
//    let id_store: String
//    let name: String
//    let website: String?
//    let address: String
//    let latitude: String
//    let longitude: String
//    let category_id: String
//    let status: String
//    let canChat: String
//    let images: [String: StoreImage]?
//    let detail: String
//    let video_url: String?
//    let telephone: String
//    let country_code: String?
//    let city_id: String?
//    let user_id: String
//    let date_created: String
//    let featured: String?
//    let tags: String?
//    let verified: String
//    let created_at: String?
//    let updated_at: String?
//    let hidden: String
//    let book: String
//    let cityStr: String?
//    let city: String?
//    let country: String?
//    let distance: String
//    let user: User
//    let cityName: String
//    let saved: String
//    let opening: String
//    let openingTimeTable: [String: OpeningTime]?
//    let gallery: Int
//    let nbrOffers: Int
//    let link: String
//    let nbrServices: Int
//    let voted: Bool
//    let nbrVotes: String
//    let votes: Int
//    let cf: CustomField
//    let cfId: String
//    let services: [String: Service]?
//}
//
//struct StoreImage: Codable {
//    let full: ImageDetail
//    let thumbnail560: ImageDetail
//    let thumbnail200: ImageDetail
//}
//
//struct ImageDetail: Codable {
//    let name: String
//    let path: String
//    let url: String
//    let ext: String
//}
//
//struct User: Codable {
//    let success: Int
//    let result: [String: UserInfo]
//}
//
//struct UserInfo: Codable {
//    let idUser: String
//    let name: String
//    let username: String
//    let password: String
//    let email: String
//    let telephone: String?
//    let images: String?
//    let status: String
//    let confirmed: String
//    let dateLogin: String?
//    let typeAuth: String?
//    let manager: String
//    let lat: String?
//    let lng: String?
//    let country: String?
//    let guestId: String
//    let grpAccessId: String
//    let createdAt: String?
//    let updatedAt: String?
//    let hidden: String
//    let phoneVerified: String
//    let hashId: String
//    let token: Token
//}
//
//struct Token: Codable {
//    let id: String
//    let uid: String
//    let type: String
//    let account: String?
//    let method: String?
//    let content: String
//    let createdAt: String
//}
//
//struct OpeningTime: Codable {
//    let day: String
//    let open: String
//    let close: String
//}
//
//struct CustomField: Codable {
//    let success: Int
//    let result: [String: FieldInfo]
//    let count: Int
//}
//
//struct FieldInfo: Codable {
//    let id: String
//    let label: String
//    let userId: String
//    let appId: String?
//    let fields: String
//    let updatedAt: String
//    let createdAt: String
//    let editable: String
//    let defaultValue: String
//}
//
//struct Service: Codable {
//    // Define your properties here
//}


//struct StoreResponse: Codable {
//    let success: Int?
//    let result: [String: Store?]
//    let args: Args
//}
//
//struct Store: Codable {
//    let sumRating: String?
//    let categoryColor: String?
//    let categoryName: String?
//    let idStore: String?
//    let name: String?
//    let website: String?
//    let address: String?
//    let latitude: String?
//    let longitude: String?
//    let categoryId: String?
//    let status: String?
//    let canChat: String?
//    let images: [String: String?]
//    let detail: String?
//    let videoUrl: String?
//    let telephone: String
//    let countryCode: String?
//    let cityId: String?
//    let userId: String?
//    let dateCreated: String?
//    let featured: String?
//    let tags: String?
//    let verified: String?
//    let createdAt: String?
//    let updatedAt: String?
//    let hidden: String?
//    let book: String?
//    let cityStr: String?
//    let city: String?
//    let country: String?
//    let distance: String?
//    let user: User
//    let cityName: String?
//    let saved: String?
//    let opening: String?
//    let openingTimeTable: [String: String?]
//    let gallery: Int?
//    let nbrOffers: Int?
//    let link: String?
//    let nbrServices: Int?
//    let voted: Bool
//    let nbrVotes: String?
//    let votes: Int?
//    let cf: CustomField
//    let cfId: String?
//    let services: [String: String?]
//}
//
//struct User: Codable {
//    let success: Int?
//    let result: [String: UserInfo?]
//}
//
//struct UserInfo: Codable {
//    let idUser: String?
//    let name: String?
//    let username: String?
//    let password: String?
//    let email: String?
//    let telephone: String?
//    let images: String?
//    let status: String?
//    let confirmed: String?
//    let dateLogin: String?
//    let typeAuth: String?
//    let manager: String?
//    let lat: String?
//    let lng: String?
//    let country: String?
//    let guestId: String?
//    let grpAccessId: String?
//    let createdAt: String?
//    let updatedAt: String?
//    let hidden: String?
//    let phoneVerified: String?
//    let hashId: String?
//    let token: Token
//}
//
//struct Token: Codable {
//    let id: String?
//    let uid: String?
//    let type: String?
//    let account: String?
//    let method: String?
//    let content: String?
//    let createdAt: String?
//}
//
//struct CustomField: Codable {
//    let success: Int?
//    let result: [String: Field?]
//    let count: Int?
//}
//
//struct Field: Codable {
//    let id: String?
//    let label: String?
//    let userId: String?
//    let appId: String?
//    let fields: String?
//    let updatedAt: String?
//    let createdAt: String?
//    let editable: String?
//    let defaultValue: String?
//}
//
//struct Args: Codable {
//    let count: Int?
//}



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryDataResponse = try? JSONDecoder().decode(CategoryDataResponse.self, from: jsonData)

import Foundation

// MARK: - CategoryDataResponse
struct CategoryDataResponse: Codable {
    let success: Int?
    let result: [String: ResultValue]?
    let args: Args?
}

// MARK: - Args
struct Args: Codable {
    let count: Int?
}

// MARK: - ResultValue
struct ResultValue: Codable {
    let sumRating: JSONNull?
    let categoryColor, category_name, name: String?
    let idStore: String?
    let website: JSONNull?
    let address, latitude, longitude, categoryID: String?
    let status, canChat: String?
    let images: [String: Images]?
    let detail: String?
    let videoURL: JSONNull?
    let telephone: String?
    let countryCode, cityID: JSONNull?
    let userID, dateCreated: String?
    let featured, tags: JSONNull?
    let verified, createdAt: String?
    let updatedAt: JSONNull?
    let hidden, book: String?
    let cityStr, city, country: JSONNull?
    let distance: String?
    let user: User?
    let cityName, saved, opening: String?
    let openingTimeTable: OpeningTimeTable?
    let gallery, nbrOffers: Int?
    let link: String?
    let nbrServices: Int?
    let voted: Bool?
    let nbrVotes: String?
    let votes: Int?
    let cf: CF?
    let cfID: CFID?
    let services: OpeningTimeTable?

    enum CodingKeys: String, CodingKey {
        case sumRating
        case categoryColor
        case category_name
        case idStore
        case name, website, address, latitude, longitude
        case categoryID
        case status, canChat, images, detail
        case videoURL
        case telephone
        case countryCode
        case cityID
        case userID
        case dateCreated
        case featured, tags, verified
        case createdAt
        case updatedAt
        case hidden, book
        case cityStr
        case city, country, distance, user
        case cityName
        case saved, opening
        case openingTimeTable
        case gallery, nbrOffers, link, nbrServices, voted
        case nbrVotes
        case votes, cf
        case cfID
        case services
    }
}

// MARK: - CF
struct CF: Codable {
    let success: Int?
    let result: CFResult?
    let count: Int?
}

// MARK: - CFResult
struct CFResult: Codable {
    let the0: Purple0?

    enum CodingKeys: String, CodingKey {
        case the0
    }
}

// MARK: - Purple0
struct Purple0: Codable {
    let id, label, userID: String?
    let appID: JSONNull?
    let fields, updatedAt, createdAt, editable: String?
    let defaultValue: String?

    enum CodingKeys: String, CodingKey {
        case id, label
        case userID
        case appID
        case fields
        case updatedAt
        case createdAt
        case editable
        case defaultValue
    }
}

enum CFID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CFID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CFID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Images
//struct Images: Codable {
//    let _0: Images0?
//
//    enum CodingKeys: String, CodingKey {
//        case _0
//    }
//}

// MARK: - Images0
struct Images: Codable {
    let full: CategoryImageSize
    let _560_560: CategoryImageSize
    let _200_200: CategoryImageSize
    let _100_100: CategoryImageSize
    let name: String

    enum CodingKeys: String, CodingKey {
        case full
        case _560_560 = "560_560"
        case _200_200 = "200_200"
        case _100_100 = "100_100"
        case name
    }
}

struct CategoryImageSize: Codable {
    let name: String
    let path: String
    let url: String
    let ext: EXT?
}

enum EXT: String, Codable {
    case jpeg = "jpeg"
    case jpg = "jpg"
    case png = "png"
}

// MARK: - OpeningTimeTable
struct OpeningTimeTable: Codable {
}

// MARK: - User
struct User: Codable {
    let success: Int?
    let result: UserResult?
}

// MARK: - UserResult
struct UserResult: Codable {
    let the0: Fluffy0?

    enum CodingKeys: String, CodingKey {
        case the0
    }
}

// MARK: - Fluffy0
struct Fluffy0: Codable {
    let idUser, name, username, password: String?
    let email: String?
    let telephone, images: JSONNull?
    let status, confirmed: String?
    let dateLogin, typeAuth: JSONNull?
    let manager: String?
    let lat, lng, country: JSONNull?
    let guestID, grpAccessID: String?
    let createdAt, updatedAt: JSONNull?
    let hidden, phoneVerified, hashID: String?
    let token: Token?

    enum CodingKeys: String, CodingKey {
        case idUser
        case name, username, password, email, telephone, images, status, confirmed, dateLogin, typeAuth, manager, lat, lng, country
        case guestID
        case grpAccessID
        case createdAt
        case updatedAt
        case hidden
        case phoneVerified
        case hashID
        case token
    }
}

// MARK: - Token
struct Token: Codable {
    let id, uid, type: String?
    let account, method: JSONNull?
    let content, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, uid, type, account, method, content
        case createdAt
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

