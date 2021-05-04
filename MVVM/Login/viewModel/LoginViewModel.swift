//
//  LoginViewModel.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class LoginViewModel {
    
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var loginModelSubject = PublishSubject<LoginModel>()
    
    var loginModelObservable: Observable<LoginModel> {
        return loginModelSubject
    }
    
    var isEmailValid: Observable<Bool> {
        return emailBehavior.asObservable().map { (email) -> Bool in
            let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isEmailEmpty
        }
    }
    
    var isPasswordValid: Observable<Bool> {
        return passwordBehavior.asObservable().map { (password) -> Bool in
            let isPasswordEmpty = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isPasswordEmpty
        }
    }
    
    var isLoginButtonEnabled: Observable<Bool> {
        return Observable.combineLatest(isEmailValid, isPasswordValid) { (isEmailEmpty, isPasswordEmpty) in
            
            let loginValid = !isEmailEmpty && !isPasswordEmpty
            return loginValid
            
        }
    }
    
    
    func fetchData() {
        
        loadingBehavior.accept(true)
        
        let LoginUrl = "https://ahlanwashlan.com.sa/api/v2/auth/login"
        
        let param: [String: Any] = [
            
            "email"    : emailBehavior.value,
            "password" : passwordBehavior.value,
            
        ]
        let headers: HTTPHeaders = [
            
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
            
        ]
        
        DispatchQueue.global(qos: .background).async {
            
            ApiServices.instance.getData2(url: LoginUrl, method: .post, params: param, encoding: JSONEncoding.default, headers: headers) { [weak self] (data: LoginModel?, dataError: LoginFailureModel?, error) in
                
                guard let self = self else { return }
                self.loadingBehavior.accept(false)
                if let error = error {
                    print(error.localizedDescription)
                }else if let dataError = dataError {
                    print(dataError)
                    print(dataError.message ?? "")
                }else {
                    guard let data = data else {
                        return
                    }
                    self.loginModelSubject.onNext(data)
                    print(data)
                }
            }
        }
    }
    
}
    

