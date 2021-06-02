//
//  AddressData.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
struct AddressData : Codable {
    let id : Int?
    let user_id : Int?
    let address : String?
    let country : String?
    let city : String?
    let postal_code : String?
    let phone : String?
    let set_default : Int?
    let lati : Double?
    let longi : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case address = "address"
        case country = "country"
        case city = "city"
        case postal_code = "postal_code"
        case phone = "phone"
        case set_default = "set_default"
        case lati = "lati"
        case longi = "longi"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        set_default = try values.decodeIfPresent(Int.self, forKey: .set_default)
        lati = try values.decodeIfPresent(Double.self, forKey: .lati)
        longi = try values.decodeIfPresent(Double.self, forKey: .longi)
    }

}
