//
//  User.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import Foundation

struct User : Codable {
    let id : Int?
    let type : String?
    let name : String?
    let email : String?
    let approved : Bool?
    let avatar : String?
    let avatar_original : String?
    let phone : String?
    let cart : Int?
    let balance : Int?
    let orders : Int?
    let wishlists : Int?
    let remember_token: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case name = "name"
        case email = "email"
        case approved = "approved"
        case avatar = "avatar"
        case avatar_original = "avatar_original"
        case phone = "phone"
        case cart = "cart"
        case balance = "balance"
        case orders = "orders"
        case wishlists = "wishlists"
        case remember_token = "remember_token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        approved = try values.decodeIfPresent(Bool.self, forKey: .approved)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        avatar_original = try values.decodeIfPresent(String.self, forKey: .avatar_original)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        cart = try values.decodeIfPresent(Int.self, forKey: .cart)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance)
        orders = try values.decodeIfPresent(Int.self, forKey: .orders)
        wishlists = try values.decodeIfPresent(Int.self, forKey: .wishlists)
        remember_token = try values.decodeIfPresent(String.self, forKey: .remember_token)
    }

}
