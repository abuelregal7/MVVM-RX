//
//  BindingAndSubscribingwallet.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import UIKit
import RxCocoa
import RxSwift

extension WalletViewController/*: UITableViewDelegate*/ {
    
    //MARK:- Bind To Hidden Table
    func bindToHiddenTable() {
        walletViewModel.isTableHiddenObservable.bind(to: self.walletContainerView.rx.isHidden).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Loading
    func subscribeToLoading() {
        walletViewModel.loadingBehavior.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Response, Like as TableView DataSource and Delegate
    func subscribeToResponse() {
        
        //walletTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        walletViewModel.walletModelObservable.bind(to: walletTableView.rx.items(cellIdentifier: walletTableViewCell, cellType: WalletTableViewCell.self)) { row, data, cell in
            cell.textLabel?.text = data.payment_method ?? ""
        }.disposed(by: disposeBag)
        
        //walletViewModel.walletModelObservable.subscribe(onNext: <#T##(([WalletData]) -> Void)?##(([WalletData]) -> Void)?##([WalletData]) -> Void#>)
    }
    
    //MARK:- Subscribe To Wallet Selection
    func subscribeToWalletSelection() {
        
        Observable
            .zip(walletTableView.rx.itemSelected, walletTableView.rx.modelSelected(WalletData.self))
            .bind { [weak self] selectedIndex, walletData in
                guard let self = self else { return }
                let alert = UIAlertController(title: "tapped!", message: "Tapped Successfully\n Your payment methos is \(walletData.payment_method ?? "")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(selectedIndex, walletData.payment_method ?? "")
            }
            .disposed(by: disposeBag)
        
//        walletTableView
//            .rx
//            .modelSelected(WalletData.self) //1
//            .subscribe(onNext: { [unowned self] walletData in // 2
//                
//                let alert = UIAlertController(title: "tapped!", message: "Tapped Successfully\n Your payment methos is \(walletData.payment_method ?? "")", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                print(walletData.payment_method ?? "")//3
//                
//                if let selectedRowIndexPath = self.walletTableView.indexPathForSelectedRow {
//                  self.walletTableView.deselectRow(at: selectedRowIndexPath, animated: true)
//                    print("selectedRowIndexPath : \(selectedRowIndexPath)")
//                } //4
//                
//            })
//            .disposed(by: disposeBag) //5
    }
    
    //MARK:- Get Wallet, Fetch Wallet, Parse Wallet
    func getWallet() {
        walletViewModel.getWallets()
    }
    
    //MARK:- Subscribe To Back Button
    func subscribeToBackButton() {
        backButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Profile Button
    func subscribeToProfileButton() {
        profileButtonOutlet
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
                if let walletVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
                    let navController = UINavigationController(rootViewController: walletVC)
                    navController.isNavigationBarHidden = true
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                    
                }
            }).disposed(by: disposeBag)
    }
    
}
