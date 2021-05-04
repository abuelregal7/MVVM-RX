//
//  LoginModel.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import Foundation

struct LoginModel : Codable {
    let result : Bool?
    let message : String?
    let access_token : String?
    let token_type : String?
    let expires_at : String?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case access_token = "access_token"
        case token_type = "token_type"
        case expires_at = "expires_at"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        token_type = try values.decodeIfPresent(String.self, forKey: .token_type)
        expires_at = try values.decodeIfPresent(String.self, forKey: .expires_at)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}
