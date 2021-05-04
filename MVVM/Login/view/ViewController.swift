//
//  ViewController.swift
//  MVVM
//
//  Created by Ahmed on 5/1/21.
//

import UIKit
import RxCocoa
import RxSwift

//MARK:- Login Class
class ViewController: UIViewController {
    
    //properties outlet
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    //instance of viewModel
    let loginViewModel = LoginViewModel()
    
    //disposeBag
    let disposeBag = DisposeBag()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonOutlet.layer.cornerRadius = 10
        
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeIsLoginEnabled()
        subscribeToLoginButton()
    }
    //MARK:- BindTextFieldsToViewModel
    func bindTextFieldsToViewModel() {
        emailTFOutlet.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTFOutlet.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToLoading
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:- SubscribeToResponse
    func subscribeToResponse() {
        loginViewModel.loginModelObservable.subscribe(onNext: {
            if $0.result == true {
                if let walletVC = UIStoryboard(name: "WalletStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController {
                    let navController = UINavigationController(rootViewController: walletVC)
                    navController.isNavigationBarHidden = false
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                    
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
                self.loginViewModel.fetchData()
        }).disposed(by: disposeBag)

    }
    
}

