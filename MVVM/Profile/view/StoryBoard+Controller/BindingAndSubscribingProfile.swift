//
//  BindingAndSubscribingProfile.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import UIKit
import RxCocoa
import RxSwift

extension ProfileVC {
    
    //MARK:- BindTextFieldsToViewModel
    func bindToTextField() {
        textFieldOutlet.rx.text.orEmpty.bind(to: profileViewModel.textFieldBehavior).disposed(by: disposeBag)
    }
    
    //MARK:- Sbuscribe To NameTF
    func sbuscribeToNameTF() {
        profileViewModel.textFieldBehavior.subscribe(onNext: { name in
            print("name is : \(name)")
        }).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToResponsePicker
    func subscribeToResponsePicker() {
        
        // this pipe displays the items in the picker view
        items2.bind(to: pickerView.rx.itemTitles) { (row, element) in
            return element.name
            
        }.disposed(by: disposeBag)
                
        // this pipe displays the picked item in the text field
        Observable.combineLatest(items2, pickerView.rx.itemSelected) { $0[$1.row].name }
            .bind(to: textFieldOutlet.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    //MARK:- SubscribeToResponsePicker (local data)
    func subscribetoResponsePicker2() {
        
        // this pipe displays the items in the picker view
        items.bind(to: pickerView.rx.itemTitles) { $1 }
            .disposed(by: disposeBag)
        
        // this pipe displays the picked item in the text field
        Observable.combineLatest(items, pickerView.rx.itemSelected) { $0[$1.row] }
            .bind(to: textFieldOutlet.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK:- Get User
    func getUser() {
        profileViewModel.getUser()
    }
    
    //MARK:- Subscribe To Loading
    func subscribeToLoading() {
        profileViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- Subscribe To Response, Like as TableView DataSource and Delegate
    func subscribeToResponse() {
        profileViewModel.profileModelObservable.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.idLabelOutlet.text = $0.id
            self.creatAtLabelOutlet.text = $0.createdAt
        }).disposed(by: disposeBag)
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
    
    //MARK:- Subscribe To Picker Button
    func subscribeToPickerButton() {
        pickerButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
            }).disposed(by: disposeBag)
    }
    
}
