//
//  ModelError.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation

struct ModelError : Codable {
    let data : [String]?
    let success : Bool?
    let status : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case success = "success"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([String].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
