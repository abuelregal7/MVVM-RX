//
//  ProfileAPI.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import Foundation
import Alamofire

//MARK:- ProfileAPIProtocol
protocol ProfileAPIProtocol {
    typealias completionForProfileModelAndNetworkError = (Result<ProfileModel?, NetworkError>) -> Void
    func getuser(completion: @escaping completionForProfileModelAndNetworkError)
}
//MARK:- ProfileAPI
class ProfileAPI: ProfileAPIProtocol {
    
    func getuser(completion: @escaping completionForProfileModelAndNetworkError) {
        let url = "https://reqres.in/api/users"
        ApiServices.instance.ParseData(url: url, methodType: .post, parameters: nil, headers: nil) { (result) in
            completion(result)
        }
    }
    
}
//MARK:- End Of Class
