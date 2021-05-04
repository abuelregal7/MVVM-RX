//
//  CategoryData.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation

struct WalletData : Codable {
    let amount : String?
    let payment_method : String?
    let approval_string : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case amount = "amount"
        case payment_method = "payment_method"
        case approval_string = "approval_string"
        case date = "date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        approval_string = try values.decodeIfPresent(String.self, forKey: .approval_string)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
