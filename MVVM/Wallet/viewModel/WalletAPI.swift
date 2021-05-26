//
//  WalletAPI.swift
//  MVVM
//
//  Created by Ahmed on 5/4/21.
//

import Foundation
import Alamofire

//MARK:- WalletAPIProtocol
protocol WalletAPIProtocol {
    typealias completionForWalletModelAndNetworkError = (Result<WalletModel?, NetworkError>) -> Void
    func getWallet(completion: @escaping completionForWalletModelAndNetworkError)
}
//MARK:- WalletAPI
class WalletAPI: WalletAPIProtocol {
    
    func getWallet(completion: @escaping completionForWalletModelAndNetworkError) {
        
        let walletURL = "https://ahlanwashlan.com.sa/api/v2/wallet/history/49"
        
        ApiServices.instance.ParseData(url: walletURL, methodType: .get, parameters: nil, headers: nil) { (result) in
            completion(result)
        }
    }
    
}
//MARK:- End Of Class
