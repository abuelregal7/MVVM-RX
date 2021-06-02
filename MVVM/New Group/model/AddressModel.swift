//
//  AddressModel.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
struct AddressModel : Codable {
    let data : [AddressData]?
    let success : Bool?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case success = "success"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AddressData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
