//
//  WalletViewModel.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation
import RxCocoa
import RxSwift

//MARK:- WalletViewModel
class WalletViewModel {
    
    // BehaviorRelay and publishSubject proberties
    var loadingBehavior              = BehaviorRelay<Bool>(value: false)
    private var isTableHidden        = BehaviorRelay<Bool>(value: false)
    
    private var walletModelSubjectData   = PublishSubject<[WalletData]>()
    private var walletModelSubjectModel  = PublishSubject<WalletModel>()
    
    //MARK:- walletModelObservable
    var walletModelObservable: Observable<[WalletData]> {
        return walletModelSubjectData
    }
    //MARK:- walletModelObservable2
    var walletModelObservable2: Observable<WalletModel> {
        return walletModelSubjectModel
    }
    //MARK:- isTableHiddenObservable
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    //MARK:- Get Wallets request
    func getWallets() {
        
        loadingBehavior.accept(true)
        let api: WalletAPIProtocol = WalletAPI()
        api.getWallet { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            
            case .success(let response):
                
                guard let data = response else { return }
                print(data)
                
                guard let wallets = data.data else { return }
                print(wallets)
                
                if !wallets.isEmpty {
                    self.walletModelSubjectData.onNext(data.data ?? [])
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
}
//MARK:- End Of Class
