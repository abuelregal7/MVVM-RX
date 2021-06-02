//
//  DeleteAddressModel.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
struct DeleteAddressModel : Codable {
    let result : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
