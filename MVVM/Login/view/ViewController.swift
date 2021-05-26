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
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    //instance of viewModel
    let loginViewModel = LoginViewModel()
    var error = ""
    //disposeBag
    let disposeBag = DisposeBag()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonOutlet.layer.cornerRadius = 10
        
        callBingingAndSubscribing()
    }
    //MARK:- CallBinging And Subscribing
    func callBingingAndSubscribing() {
        sbuscribeToEmailTFAndPasswordTF()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToAlert()
        //subscribeIsLoginEnabled()
        subscribeToLoginButton()
        subscribeToBackButton()
        //emailTFOutlet.text = "momo@a.com"
    }
    //MARK:- Back Button
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
    
}
