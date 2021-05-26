//
//  ProfileModel.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import Foundation
struct ProfileModel : Codable {
    
    let id : String?
    let createdAt : String?
    

    enum CodingKeys: String, CodingKey {

        
        case id = "id"
        case createdAt = "createdAt"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }

}
