//
//  ProfileViewModel.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import Foundation
import RxCocoa
import RxSwift

//MARK:- ProfileViewModel
class ProfileViewModel {
    // BehaviorRelay and publishSubject proberties
    var loadingBehavior   = BehaviorRelay<Bool>(value: false)
    var idBehavior        = BehaviorRelay<String>(value: "")
    var creatAtBehavior   = BehaviorRelay<String>(value: "")
    var textFieldBehavior = BehaviorRelay<String>(value: "")
    
    private var profileModelSubject = PublishSubject<ProfileModel>()
    //MARK:- profileModelObservable
    var profileModelObservable: Observable<ProfileModel> {
        return profileModelSubject
    }
    //MARK:- textFieldObservable
    var textFieldObservable: Observable<String> {
        return textFieldBehavior.asObservable()
    }
    //MARK:- Get User request
    func getUser() {
        
        loadingBehavior.accept(true)
        let api: ProfileAPIProtocol = ProfileAPI()
        api.getuser { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            
            case .success(let response):
                
                guard let data = response else { return }
                print(data)
                self.profileModelSubject.onNext(data)
                
            case .failure(let error):
                
                print(error.localizedDescription)
                print(error.errorDescription ?? "")
                
            }
        }
    }
    
}
//MARK:- End Of Class
