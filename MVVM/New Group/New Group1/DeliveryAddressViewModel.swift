//
//  DeliveryAddressViewModel.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
import RxCocoa
import RxSwift

class DeliveryAddressViewModel {
    
    // BehaviorRelay and publishSubject proberties
    var loadingBehavior                   = BehaviorRelay<Bool>(value: false)
    var alertBehavior                     = BehaviorRelay<Bool>(value: false)
    private var isTableHidden             = BehaviorRelay<Bool>(value: false)
    
    var error                             = ""
    var error2                            = PublishSubject<String>()
    var error3                            = BehaviorRelay<String>(value: "")
    
    private var addressModelSubjectData   = PublishSubject<[AddressData]>()
    private var addressModelSubjectModel  = PublishSubject<AddressModel>()
    
    private var deleteModelSubjectData    = PublishSubject<DeleteAddressModel>()
    
    //MARK:- addressModelObservable
    var addressModelObservable: Observable<[AddressData]> {
        return addressModelSubjectData
    }
    //MARK:- addressModelObservable2
    var addressModelObservable2: Observable<AddressModel> {
        return addressModelSubjectModel
    }
    
    var deleteModelObservable: Observable<DeleteAddressModel> {
        return deleteModelSubjectData
    }
    
    //MARK:- isTableHiddenObservable
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
    func getAddress() {
        
        loadingBehavior.accept(true)
        let api: DeleveryAddressAPIProtocol = DeleveryAddressAPI()
        api.getAddress { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result{
            case .success(let response):
                guard let data = response else { return }
                print(data)
                guard let address = data.data else { return }
                print(address)
                if !address.isEmpty {
                    self.addressModelSubjectData.onNext(data.data ?? [])
                    self.isTableHidden.accept(false)
                }else{
                    self.isTableHidden.accept(true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                print(error.errorDescription ?? "")
            }
        }
        
    }
    
    func deleteAddress(address_id : Int  ,row : Int) {
        loadingBehavior.accept(true)
        let api: DeleteAddressAPIProtocol = DeleteAddressAPI(id: address_id)
        api.deleteAddress { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result{
            
            case .success(let response):
                guard let data = response else { return }
                print(data)
                self.deleteModelSubjectData.onNext(data)
                self.alertBehavior.accept(true)
                self.getAddress()
            case .failure(let error):
                print(error.localizedDescription)
                print(error.errorDescription ?? "")
                self.alertBehavior.accept(false)
                self.error = error.errorDescription ?? ""
                self.error2.onNext(error.errorDescription ?? "")
                self.error3.accept(error.errorDescription ?? "")
            }
        }
    }
    
}
