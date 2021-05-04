//
//  Links.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation

struct WalletLinks : Codable {
    let first : String?
    let last : String?
    let prev : String?
    let next : String?

    enum CodingKeys: String, CodingKey {

        case first = "first"
        case last = "last"
        case prev = "prev"
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last = try values.decodeIfPresent(String.self, forKey: .last)
        prev = try values.decodeIfPresent(String.self, forKey: .prev)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }

}
