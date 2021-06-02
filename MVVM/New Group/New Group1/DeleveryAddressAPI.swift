//
//  DeleveryAddressAPI.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
import Alamofire

protocol DeleveryAddressAPIProtocol {
    func getAddress(compeletion: @escaping (Result<AddressModel?, NetworkError>) -> Void)
}

class DeleveryAddressAPI: DeleveryAddressAPIProtocol {
    func getAddress(compeletion: @escaping (Result<AddressModel?, NetworkError>) -> Void) {
        
        let postsUrl = "https://ahlanwashlan.com.sa/api/v2/user/shipping/address/51"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE5ZjUzMzVkODNhNDNlZjFhYTI4MjIxNTgwMzAzYzY5N2Q4ZGM1ZTExNDRhZmFmY2Y3NDkwZGQzNWUwYmViNmY5M2IyYjMyMTFmZDhjZDRlIn0.eyJhdWQiOiIxIiwianRpIjoiMTlmNTMzNWQ4M2E0M2VmMWFhMjgyMjE1ODAzMDNjNjk3ZDhkYzVlMTE0NGFmYWZjZjc0OTBkZDM1ZTBiZWI2ZjkzYjJiMzIxMWZkOGNkNGUiLCJpYXQiOjE2MTk1MzA1MjYsIm5iZiI6MTYxOTUzMDUyNiwiZXhwIjoxNjUxMDY2NTI2LCJzdWIiOiI1MSIsInNjb3BlcyI6W119.UXt6xb01mpisXagp6aoVfTid727aXPkBKX-DAhTO4n8oOLcZoYYE0M00zMem45ydMGtjO2eCaDajl3tAbhzS9044Jy2LzBWmqXUNyIhYI0if7dvMKcQZr4X5bwoKO1vASNELLosgw_2fncI8fuRMGoTZ-3078QG9PFQbtfIobyXLe1IRgmgJ25CQWB2jBKUMnxMgIpf2P7C6aJsw72IFmRqYkKGFBv6-_QRl1vIOO86SvASrL1dEn15mJu1f9zqWKDX7N3S2neC2rr7OQawRCkjsGoVsKfSkkRXJIRlofwLkDpJ8DRRsDqmG0z5f1wDUs2f3PxRnJi-7NbAEbCo4OhjYkPyG_MgeCb9twfiltPw609-m9cGVBkrPUASj_4cgnnPN_Tnz5K-R8N0c1UGnkg0o8ov7TQDrcWBb0XV2TcF4c7RoosEX6R_wMQ2_JzqOq-nSajI6cq6H8zPb-fbxuJte_77SwZHCbaCQjSQjmnkgGwVuZzW2TbPnWv5PUuTvfUuTGgpL87eSjMn8Snk0Ri_Gs0gduwla3jtf_me19oeAjmRY6LILLcaqhZj6P34iFAc4eAcX42UP2Q2Ng4qE44qHKjfMYGsuRusiZfTB5DUDjUjUet9GN3lbjZoNDy7718jYCEFWMlB8yeJUc4u0PPm2bB30zYGByTgIwNRxeAU"
        ]
        
        ApiServices.instance.ParseData(url: postsUrl, methodType: .get, parameters: nil, headers: headers) { (result) in
            compeletion(result)
        }
    }
}
