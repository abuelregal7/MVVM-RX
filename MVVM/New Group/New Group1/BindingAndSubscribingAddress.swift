//
//  BindingAndSubscribingAddress.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension DeliveryAddressVC {
    
    //MARK:- Bind To Hidden Table
    func bindToHiddenTable() {
        addressViewModel.isTableHiddenObservable.bind(to: self.addressContainerView.rx.isHidden).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToAlert Success, Wrong, Other
    func subscribeToAlert() {
        
        addressViewModel.alertBehavior.subscribe(onNext: { [weak self] alert in
            guard let self = self else { return }
            if alert == false {
                self.addressViewModel.error2.subscribe(onNext: { [weak self] msg in
                    guard let self = self else { return }
                    print(msg)
                    let alert = UIAlertController(title: "Error", message: "Something went wrong\("\n\(msg)")", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }).disposed(by: self.disposeBag)
            }else if alert == true {
                print("success")
                let alert = UIAlertController(title: "Error", message: "Delete Address Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                print("other")
            }
        }).disposed(by: disposeBag)
        
    }
    
    //MARK:- Subscribe To Response, Like as TableView DataSource and Delegate
    func subscribeToResponse() {
        
        addressViewModel.addressModelObservable.bind(to: addressTableView.rx.items(cellIdentifier: addressTableViewCell, cellType: DeliveryAddressCell.self)) { [weak self] row, data, cell in
            guard let self = self else { return }
            //cell.textLabel?.text = data.payment_method ?? ""
            cell.configure(address: data)
            
            cell.deleteAddress
                .rx
                .tap
                .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                    print("buttonTapped")
                    print(row)
                    let alert = UIAlertController(title: "Delete Address", message: "Are you sure?, you want to delete this Address", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
                        guard let self = self else { return }
                        
                        self.addressViewModel.deleteAddress(address_id: data.id ?? 0, row: row)
                        
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }).disposed(by: self.disposeBag)
            
            cell.defultAddress
                .rx
                .tap
                .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                    print("buttonTapped")
                    print(row)
                    let alert = UIAlertController(title: "Set Defult Address", message: "Are you sure?, you want to set this Address as defult", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
                        guard let self = self else { return }
                        
                        print(data.set_default ?? 0)
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }).disposed(by: self.disposeBag)
            
        }.disposed(by: disposeBag)
        
        //walletViewModel.walletModelObservable.subscribe(onNext: <#T##(([WalletData]) -> Void)?##(([WalletData]) -> Void)?##([WalletData]) -> Void#>)
    }
    
    //MARK:- Subscribe To Loading
    func subscribeToLoading() {
        addressViewModel.loadingBehavior.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- Get Address, Fetch Address, Parse Address
    func getAddress() {
        addressViewModel.getAddress()
    }
    
    //MARK:- Subscribe To Back Button
    func subscribeToBackButton() {
        backButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                self.dismiss(animated: true, completion: nil)
                
            }).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Back Button
    func subscribeTonewAddressButton() {
        newAddressButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                if let addNewAddressVC = UIStoryboard(name: "DeliveryAddress", bundle: nil).instantiateViewController(withIdentifier: "AddNewAddressVC") as? AddNewAddressVC {
                    let navController = UINavigationController(rootViewController: addNewAddressVC)
                    navController.isNavigationBarHidden = true
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                    
                }
                
            }).disposed(by: disposeBag)
    }
    
}
