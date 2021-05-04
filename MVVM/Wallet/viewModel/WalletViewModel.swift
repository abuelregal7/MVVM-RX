//
//  WalletViewModel.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//

import Foundation
import RxCocoa
import RxSwift

class WalletViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden   = BehaviorRelay<Bool>(value: false)
    
    private var walletModelSubject = PublishSubject<[WalletData]>()
    private var walletModelSubject2 = PublishSubject<WalletModel>()
    
    var walletModelObservable: Observable<[WalletData]> {
        return walletModelSubject
    }
    var walletModelObservable2: Observable<WalletModel> {
        return walletModelSubject2
    }
    
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
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
                    self.walletModelSubject.onNext(data.data ?? [])
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
