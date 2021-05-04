//
//  LoginFailureModel.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import Foundation

struct LoginFailureModel : Codable {
    let result : Bool?
    let message : String?
    let user : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user = try values.decodeIfPresent(String.self, forKey: .user)
    }

}
