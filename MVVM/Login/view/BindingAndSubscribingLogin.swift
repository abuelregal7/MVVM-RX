//
//  BindingAndSubscribingLogin.swift
//  MVVM
//
//  Created by Ahmed on 5/23/21.
//

import UIKit
import RxCocoa
import RxSwift

//MARK: - Binging
extension ViewController {
    
    //MARK:- BindTextFieldsToViewModel
    func bindTextFieldsToViewModel() {
        emailTFOutlet.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTFOutlet.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    //MARK:- SbuscribeToEmailTFAndPasswordTF
    func sbuscribeToEmailTFAndPasswordTF() {
        loginViewModel.emailBehavior.subscribe(onNext: { email in
            print("email is : \(email)")
        }).disposed(by: disposeBag)
        
        loginViewModel.passwordBehavior.subscribe(onNext: { password in
            print("password is : \(password)")
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - Subscribing
extension ViewController {
    
    //MARK:- SubscribeToLoading
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToAlert Success, Wrong, Other
    func subscribeToAlert() {
        loginViewModel.alertBehavior.subscribe(onNext: { [weak self] alert in
            guard let self = self else { return }
            if alert == false {
                print("Error, \(alert)")
                self.error = self.loginViewModel.error
                self.loginViewModel.error2.subscribe(onNext: { [weak self] msg in
                    guard let self = self else { return }
                    print(msg)
                    let alert = UIAlertController(title: "Error", message: "Something went wrong\("\n\(msg)")", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }).disposed(by: self.disposeBag)
            }else if alert == true {
                print("success")
            }else{
                print("other")
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToResponse
    func subscribeToResponse() {
        
        loginViewModel.loginModelObservable.subscribe(onNext: { [weak self] result in
            
            guard let self = self else { return }
            if result.result == false {
                print("Error, result is: \(result.result ?? false)")
            }else if result.result == true {
                //$0.result == true
                print("Error, result is: \(result.result ?? true)")
                if let walletVC = UIStoryboard(name: "WalletStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController {
                    let navController = UINavigationController(rootViewController: walletVC)
                    navController.isNavigationBarHidden = false
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                    
                }
            }else{
                print("Other")
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeIsLoginEnabled
    func subscribeIsLoginEnabled() {
        loginViewModel.isLoginButtonEnabled.bind(to: loginButtonOutlet.rx.isEnabled).disposed(by: disposeBag)
    }
    
    
    //MARK:- SubscribeToLoginButton
    func subscribeToLoginButton() {
        loginButtonOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .filter({ [weak self] (_) -> Bool in
                guard let self = self else { return false}
                guard !(self.emailTFOutlet.text ?? "").isEmpty else {
                    let alert = UIAlertController(title: "Error", message: "email are empty, insert email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.emailTFOutlet.becomeFirstResponder()
                    return false
                }
                guard self.emailTFOutlet.text!.isValidEmail else {
                    let alert = UIAlertController(title: "Error", message: "email are not valid, valid email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                guard !(self.passwordTFOutlet.text ?? "").isEmpty, self.passwordTFOutlet.text!.count >= 6 else {
                    let alert = UIAlertController(title: "Error", message: "password are empty, insert password, and minimum 6 ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.passwordTFOutlet.becomeFirstResponder()
                    return false
                }
                return true
            })
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
                //                let alert = UIAlertController(title: "success", message: "All fields are valid", preferredStyle: .alert)
                //                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //                self.present(alert, animated: true, completion: nil)
                
                self.loginViewModel.sendData()
            }).disposed(by: disposeBag)
        
    }
    
}
