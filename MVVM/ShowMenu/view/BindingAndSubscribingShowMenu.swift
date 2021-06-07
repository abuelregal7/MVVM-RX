//
//  BindingAndSubscribingShowMenu.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import Foundation
import RxCocoa
import RxSwift
import RSSelectionMenu

extension ShowMenuVC {
    
    //MARK:- set Up Menu
    func setUpMenu() {
        
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: self.simpleDataArray) { (cell, name, indexPath) in

            cell.textLabel?.text = name

            // customization
            // set image
            //cell.imageView?.image = #imageLiteral(resourceName: "profile")
            cell.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        //selectionMenu.cellSelectionStyle = .tickmark
        // or
        selectionMenu.cellSelectionStyle = .checkbox
        
        //setSelectionItems
        selectionMenu.setSelectedItems(items: self.simpleSelectedArray) { (name, index, selected, selectedItems) in
            print(name ?? "", index, selected, selectedItems)
            print(name ?? "", index, selected, selectedItems.joined(separator: " , "))
            
            if selectedItems.isEmpty {
                self.categoriesLabelOutlet.text = ""
            }else{
                self.categoriesLabelOutlet.text = "\(selectedItems.joined(separator: " , "))"
            }
            
        }
        
        // show as formSheet
        selectionMenu.show(style: .bottomSheet(barButton: UIBarButtonItem(), height: 200.0), from: self)
        
    }
    
    //MARK:- Subscribe To PopUp Menu Button
    func subscribeToPopUpMenuButton() {
        popUpMenuButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                self.popUpMenuButtonOutlet.shake()
                self.setUpMenu()
                
            }).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Back Button
    func subscribeToBackButton() {
        backbuttonOutlet
            .rx
            .tap
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                self.dismiss(animated: true, completion: nil)
                
            }).disposed(by: disposeBag)
    }
    //MARK:- Subscribe To Address Button
    func subscribeToAddressButton() {
        addressButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                self.addressButtonOutlet.shake()
                if let deliveryAddressVC = UIStoryboard(name: "DeliveryAddress", bundle: nil).instantiateViewController(withIdentifier: "DeliveryAddressVC") as? DeliveryAddressVC {
                    let navController = UINavigationController(rootViewController: deliveryAddressVC)
                    navController.isNavigationBarHidden = false
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                    
                }
                
            }).disposed(by: disposeBag)
    }
    
}
