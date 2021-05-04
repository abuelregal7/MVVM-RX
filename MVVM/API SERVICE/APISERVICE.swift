//
//  APISERVICE.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import Foundation
import UIKit
import Alamofire

//MARK:- Class Api Service

/// Api Services is a class to fetch and parse data from web service "End Point"

public typealias DataResponseType  = AFDataResponse<Any>

class ApiServices {

    private init() {}
    //MARK:- Singleton
    // singleton
    static let instance = ApiServices()

    var dataResponse: DataResponseType?
    
    //(T?, E?, Error?)
    //MARK:- Function To Fetch And Parse Data ( (T?, E?, Error?), (Result<T?,NSError()>) )
    //(T?, E?, Error?)
    /// Fetch Data is a func to fetch and parse data from web service "End Point", (T?, E?, Error?)
    func FetchData<T: Codable, E: Codable>(url: String, methodType: Alamofire.HTTPMethod?, parameters: [String: Any]? = nil, headers: HTTPHeaders?, completion: @escaping (T?, E?, Error?) -> Void) {

        AF.request(url, method: methodType ?? .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in

                print(response)

                switch response.result {

                case .success(let value):
                    print(value)
                    //if let JSON = value as? Dictionary<String, AnyObject> {}
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode == 200 || (statusCode >= 200 && statusCode <= 299) {
                        print("Status code : \(statusCode)")
                        do {

                            // Successful request
                            guard let theJsonResponse =  try? response.result.get() else {
                                // ADD Custom Error
                                return
                            }
                            guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonResponse, options: []) else {
                                // ADD Custom Error
                                return
                            }
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                            guard let theJsonObj = try decoder.decode(T?.self, from: theJsonData) else {
                                // ADD Custom Error
                                return
                            }
                            completion(theJsonObj, nil, nil)

                        }catch let jsonError {

                            print(jsonError)
                        }
                    }


                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? 0
                    if statusCode == 401 || (statusCode >= 400 && statusCode <= 499) {
                        print("Status code : \(statusCode)")
                        do {
                            // Successful request
                            guard let theJsonResponse =  try? response.result.get() else {

                                // ADD Custom Error

                                return
                            }
                            guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonResponse, options: []) else {

                                // ADD Custom Error

                                return
                            }

                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                            //decoder.keyDecodingStrategy = .convertFromSnakeCase
                            guard let dataErrorJsonObj = try decoder.decode(E?.self, from: theJsonData) else {
                                // ADD Custom Error
                                return
                            }

                            completion(nil, dataErrorJsonObj, nil)

                        }catch let jsonError {

                            print(jsonError)

                        }
                    }else {
                        completion(nil, nil, error)
                    }

                }

            }
    }
    
    func getData2<T: Decodable, E: Decodable>(url: String, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?, E?, Error?)->()) {
        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData, nil, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                case .failure(let error):
                    // switch on Error Status Code
                    guard let data = response.data else { return }
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode {
                    case 400..<500:
                        do {
                            let jsonError = try JSONDecoder().decode(E.self, from: data)
                            completion(nil, jsonError, nil)
                        } catch let jsonError {
                            print(jsonError)
                        }
                    default:
                        completion(nil, nil, error)
                    }
                }
        }
    }
    

    //(Result<M?,NSError>)
    /// Fetch Data is a func to fetch and parse data from web service "End Point", (Result<T?,NSError()>)
    func ParseData<T: Codable>(url: String, methodType: Alamofire.HTTPMethod?, parameters: [String: Any]? = nil, headers: HTTPHeaders?, completion: @escaping (Result<T?,NetworkError>) -> Void) {
        
        
        
        AF.request(url, method: methodType ?? .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { [weak self] (response) in

                print(response)
                
                guard let self = self else { return }
                
                guard let statusCode = response.response?.statusCode else {

                    completion(.failure(NetworkError((self.dataResponse?.response!.statusCode)!)))
                    return
                }
                //if statusCode == 200
                //if statusCode >= 200 && statusCode <= 299
                //if statusCode < 300
                if statusCode >= 200 && statusCode <= 299 {

                    // Successful request
                    guard let theJsonResponse =  try? response.result.get() else {

                        // ADD Custom Error
                        completion(.failure(NetworkError((self.dataResponse?.response!.statusCode)!)))
                        return
                    }

                    guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonResponse, options: []) else {

                        // ADD Custom Error
                        completion(.failure(.parsingJSONError))
                        return
                    }
                    guard let theJsonObj = try? JSONDecoder().decode(T?.self, from: theJsonData) else {

                        // ADD Custom Error
                        completion(.failure(.parsingJSONError))
                        return
                    }
                    completion(.success(theJsonObj))
                }else if statusCode == 100 {
                    // ADD custom error base on status code 100
                    completion(.failure(.continuee))
                }else if statusCode == 101 {
                    // ADD custom error base on status code 100
                    completion(.failure(.switchingProtocols))
                }else if statusCode == 102 {
                    // ADD custom error base on status code 100
                    completion(.failure(.processing))
                }else if statusCode == 200 {
                    // ADD custom error base on status code 100
                    completion(.failure(.ok))
                }else if statusCode == 201 {
                    // ADD custom error base on status code 100
                    completion(.failure(.created))
                }else if statusCode == 202 {
                    // ADD custom error base on status code 100
                    completion(.failure(.accepted))
                }else if statusCode == 203 {
                    // ADD custom error base on status code 100
                    completion(.failure(.nonAuthoritativeInformation))
                }else if statusCode == 204 {
                    // ADD custom error base on status code 100
                    completion(.failure(.noContent))
                }else if statusCode == 205 {
                    // ADD custom error base on status code 100
                    completion(.failure(.resetContent))
                }else if statusCode == 206 {
                    // ADD custom error base on status code 100
                    completion(.failure(.partialContent))
                }else if statusCode == 207 {
                    // ADD custom error base on status code 100
                    completion(.failure(.multiStatus))
                }else if statusCode == 208 {
                    // ADD custom error base on status code 100
                    completion(.failure(.alreadyReported))
                }else if statusCode == 209 {
                    // ADD custom error base on status code 209
                    completion(.failure(.notAuthenticated))
                }else if statusCode == 226 {
                    // ADD custom error base on status code 100
                    completion(.failure(.IMUsed))
                }else if statusCode == 300 {
                    // ADD custom error base on status code 100
                    completion(.failure(.multipleChoices))
                }else if statusCode == 301 {
                    // ADD custom error base on status code 100
                    completion(.failure(.movedPermanently))
                }else if statusCode == 302 {
                    // ADD custom error base on status code 100
                    completion(.failure(.found))
                }else if statusCode == 303 {
                    // ADD custom error base on status code 100
                    completion(.failure(.seeOther))
                }else if statusCode == 304 {
                    // ADD custom error base on status code 100
                    completion(.failure(.notModified))
                }else if statusCode == 305 {
                    // ADD custom error base on status code 100
                    completion(.failure(.useProxy))
                }else if statusCode == 306 {
                    // ADD custom error base on status code 100
                    completion(.failure(.switchProxy))
                }else if statusCode == 307 {
                    // ADD custom error base on status code 100
                    completion(.failure(.temporaryRedirect))
                }else if statusCode == 308 {
                    // ADD custom error base on status code 100
                    completion(.failure(.permenantRedirect))
                }else if statusCode == 400 {
                    // ADD custom error base on status code 100
                    completion(.failure(.noConnection))
                }else if statusCode == 401 {
                    // ADD custom error base on status code 100
                    completion(.failure(.unauthorized))
                }else if statusCode == 402 {
                    // ADD custom error base on status code 100
                    completion(.failure(.paymentRequired))
                }else if statusCode == 403 {
                    // ADD custom error base on status code 100
                    completion(.failure(.forbidden))
                }else if statusCode == 404 {
                    // ADD custom error base on status code 100
                    completion(.failure(.notFound))
                }else if statusCode == 405 {
                    // ADD custom error base on status code 100
                    completion(.failure(.methodNotAllowed))
                }else if statusCode == 406 {
                    // ADD custom error base on status code 100
                    completion(.failure(.notAcceptable))
                }else if statusCode == 407 {
                    // ADD custom error base on status code 100
                    completion(.failure(.proxyAuthenticationRequired))
                }else if statusCode == 408 {
                    // ADD custom error base on status code 100
                    completion(.failure(.requestTimeout))
                }else if statusCode == 409 {
                    // ADD custom error base on status code 100
                    completion(.failure(.conflict))
                }else if statusCode == 410 {
                    // ADD custom error base on status code 100
                    completion(.failure(.gone))
                }else if statusCode == 411 {
                    // ADD custom error base on status code 100
                    completion(.failure(.lengthRequired))
                }else if statusCode == 412 {
                    // ADD custom error base on status code 100
                    completion(.failure(.preconditionFailed))
                }else if statusCode == 413 {
                    // ADD custom error base on status code 100
                    completion(.failure(.payloadTooLarge))
                }else if statusCode == 414 {
                    // ADD custom error base on status code 100
                    completion(.failure(.URITooLong))
                }else if statusCode == 415 {
                    // ADD custom error base on status code 100
                    completion(.failure(.unsupportedMediaType))
                }else if statusCode == 416 {
                    // ADD custom error base on status code 100
                    completion(.failure(.rangeNotSatisfiable))
                }else if statusCode == 417 {
                    // ADD custom error base on status code 100
                    completion(.failure(.expectationFailed))
                }else if statusCode == 418 {
                    // ADD custom error base on status code 100
                    completion(.failure(.teapot))
                }else if statusCode == 421 {
                    // ADD custom error base on status code 100
                    completion(.failure(.misdirectedRequest))
                }else if statusCode == 422 {
                    // ADD custom error base on status code 100
                    completion(.failure(.unprocessableEntity))
                }else if statusCode == 423 {
                    // ADD custom error base on status code 100
                    completion(.failure(.locked))
                }else if statusCode == 424 {
                    // ADD custom error base on status code 100
                    completion(.failure(.failedDependency))
                }else if statusCode == 426 {
                    // ADD custom error base on status code 100
                    completion(.failure(.upgradeRequired))
                }else if statusCode == 428 {
                    // ADD custom error base on status code 100
                    completion(.failure(.preconditionRequired))
                }else if statusCode == 429 {
                    // ADD custom error base on status code 100
                    completion(.failure(.tooManyRequests))
                }else if statusCode == 431 {
                    // ADD custom error base on status code 100
                    completion(.failure(.requestHeaderFieldsTooLarge))
                }else if statusCode == 444 {
                    // ADD custom error base on status code 100
                    completion(.failure(.noResponse))
                }else if statusCode == 451 {
                    // ADD custom error base on status code 100
                    completion(.failure(.unavailableForLegalReasons))
                }else if statusCode == 495 {
                    // ADD custom error base on status code 100
                    completion(.failure(.SSLCertificateError))
                }else if statusCode == 496 {
                    // ADD custom error base on status code 100
                    completion(.failure(.SSLCertificateRequired))
                }else if statusCode == 497 {
                    // ADD custom error base on status code 100
                    completion(.failure(.HTTPRequestSentToHTTPSPort))
                }else if statusCode == 499 {
                    // ADD custom error base on status code 100
                    completion(.failure(.clientClosedRequest))
                }else if statusCode == 500 {
                    // ADD custom error base on status code 100
                    completion(.failure(.serverError))
                }else if statusCode == 501 {
                    // ADD custom error base on status code 100
                    completion(.failure(.notImplemented))
                }else if statusCode == 502 {
                    // ADD custom error base on status code 100
                    completion(.failure(.badGateway))
                }else if statusCode == 503 {
                    // ADD custom error base on status code 100
                    completion(.failure(.serviceUnavailable))
                }else if statusCode == 504 {
                    // ADD custom error base on status code 100
                    completion(.failure(.gatewayTimeout))
                }else if statusCode == 505 {
                    // ADD custom error base on status code 100
                    completion(.failure(.HTTPVersionNotSupported))
                }else if statusCode == 506 {
                    // ADD custom error base on status code 100
                    completion(.failure(.variantAlsoNegotiates))
                }else if statusCode == 507 {
                    // ADD custom error base on status code 100
                    completion(.failure(.insufficientStorage))
                }else if statusCode == 508 {
                    // ADD custom error base on status code 100
                    completion(.failure(.loopDetected))
                }else if statusCode == 510 {
                    // ADD custom error base on status code 100
                    completion(.failure(.notExtended))
                }else if statusCode == 511 {
                    // ADD custom error base on status code 100
                    completion(.failure(.networkAuthenticationRequired))
                }
                else{
                    completion(.failure(.unknownError))
                }
                //NSError()
            }
    }

    //MARK:- Function To Get Data
    /// Get Data is a func to get and parse data from web service "End Point"
    func getData<T: Decodable>(url: String, methodType: Alamofire.HTTPMethod?, parameters: [String: Any]? = nil, completion: @escaping (T?, Error?) -> Void) {

        let headers = HTTPHeaders()
        //var headers: HTTPHeaders? = nil

        AF.request(url, method: methodType ?? .post, parameters: parameters, headers: headers).responseJSON { (response) in

            print(response)

            guard let data = response.data else { return }
            print(data)


            switch response.result {

            case .success(let value):

                if let JSON = value as? Dictionary<String, AnyObject> {
                    print(JSON)

                    if let message = JSON["message"] as? String {
                        print("message is : \(message)")

                    }else {
                        do {

                            let data = try JSONDecoder().decode(T?.self, from: data)
                            completion(data, nil)

                        }catch let jsonError {

                            print(jsonError)
                            completion(nil, jsonError)

                        }
                    }
                }

            case .failure(let error):

                print(error)
                completion(nil, error)

            }

        }
    }

    //MARK:- Function To Fetch Data
    /// Fetch Data is a func to fetch and parse data from web service "End Point"
    func fetchData2<T: Codable, E: Codable>(url: String, methodType: Alamofire.HTTPMethod?, parameters: [String: Any]? = nil, headers: HTTPHeaders?, completion: @escaping (T?, E?, _ success:Bool,_ status: Int, Error?) -> Void) {

        AF.request(url, method: methodType ?? .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                print(response)
                let statusCode = response.response?.statusCode ?? 0
                if statusCode == 200 {
                    switch response.result {
                    case .success(let value):
                        print(value)
                        let statusCode = response.response?.statusCode ?? 0
                        if statusCode == 200  {
                            print("Status code : \(statusCode)")
                            do {
                                guard let data = response.data else { return }
                                print(data)

                                let dataJson = try JSONDecoder().decode(T?.self, from: data)
                                completion(dataJson, nil, true, statusCode, nil)

                            }catch let jsonError {

                                print(jsonError)
                            }
                        }
                    case .failure(let error):
                        let statusCode = response.response?.statusCode ?? 0
                        if statusCode == 401 {
                            print("Status code : \(statusCode)")
                            do {
                                guard let data = response.data else { return }
                                print(data)
                                let dataError = try JSONDecoder().decode(E?.self, from: data)
                                completion(nil, dataError, false, statusCode, nil)

                            }catch let jsonError {

                                print(jsonError)
                            }
                        }else {
                            completion(nil, nil, false, statusCode, error)
                            print(completion(nil, nil, false, statusCode, error))
                            print(error)
                        }
                    }
                }else {
                    print("Status code is : \(statusCode)")
                }
            }
    }


}

//MARK:- AWSError
enum AWSError: String, Error {

    case invalidUserName     = "This username created an invalid request, please try again."
    case unableToComplete    = "Unable to complete your request, please check your internet connection."
    case invalidResponse     = "Invalid response from a server, please try again"
    case invalidData         = "The data received from the server wa invalid, please try again"
    case unableToFavorite    = "there was an error favoriting this user. please try again"
    case alreadyInFavorites  = "You've already favorited this user. you must REALLY like them!"
    case unableToComplete2   = "Unable to complete your request, please check your internet connection., and check your status code"

}
