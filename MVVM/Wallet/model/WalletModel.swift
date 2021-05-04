//
//  CategoryModel.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation

struct WalletModel : Codable {
    let data : [WalletData]?
    let links : WalletLinks?
    let meta : WalletMeta?
    let success : Bool?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case links = "links"
        case meta = "meta"
        case success = "success"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([WalletData].self, forKey: .data)
        links = try values.decodeIfPresent(WalletLinks.self, forKey: .links)
        meta = try values.decodeIfPresent(WalletMeta.self, forKey: .meta)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
