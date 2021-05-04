//
//  WalletAPI.swift
//  MVVM
//
//  Created by Ahmed on 5/4/21.
//

import Foundation
import Alamofire

protocol WalletAPIProtocol {
    func getWallet(completion: @escaping (Result<WalletModel?, NetworkError>) -> Void)
}

class WalletAPI: WalletAPIProtocol {
    
    func getWallet(completion: @escaping (Result<WalletModel?, NetworkError>) -> Void) {
        
        let walletURL = "https://ahlanwashlan.com.sa/api/v2/wallet/history/49"
        
        ApiServices.instance.ParseData(url: walletURL, methodType: .get, parameters: nil, headers: nil) { (result) in
            completion(result)
        }
    }
    
}
