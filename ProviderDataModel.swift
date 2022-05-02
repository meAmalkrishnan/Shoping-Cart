//  ProviderDataModel.swift


import Foundation

struct HomeData: Codable, Hashable {
    var homeData: Array<Values>?
}

struct Values: Codable, Hashable {
    var type: String?
    var values: Array<ProviderData>?
}

struct ProviderData: Codable, Hashable {
    var id: Int?
    var name: String?
    var image_url: String?
    var banner_url: String?
    var image: String?
    var actual_price : String?
    var offer_price: String?
    var offer: Int?
    var is_express: Bool?
}
