//
//  LoginAPI.swift
//  MVVM
//
//  Created by Ahmed on 5/20/21.
//

import Foundation
import Alamofire

//MARK:- LoginAPIProtocol
protocol LoginAPIProtocol {
    typealias completionForLoginModelAndNetworkError = (Result<LoginModel?, NetworkError>) -> Void
    func sendData(completion: @escaping completionForLoginModelAndNetworkError)
}

//MARK:- LoginAPI
class LoginAPI: LoginAPIProtocol {
    
    var email = ""
    var password = ""
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func sendData(completion: @escaping completionForLoginModelAndNetworkError) {
        let LoginUrl = "https://ahlanwashlan.com.sa/api/v2/auth/login"
        
        let param: [String: Any] = [
            
            "email"    : email,
            "password" : password,
            
        ]
        let headers: HTTPHeaders = [
            
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
            
        ]
        
        DispatchQueue.global(qos: .background).async {
            ApiServices.instance.ParseData(url: LoginUrl, methodType: .post, parameters: param, headers: headers) { (result) in
                completion(result)
            }
        }
    }
    
}
//MARK:- End Of Class
