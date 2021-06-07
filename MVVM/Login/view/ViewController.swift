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
        //emailTFOutlet.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        //print("١٢٣٤٥٦٧٨٩".replacedArabicDigitsWithEnglish)
        //print("123456789".replacedEnglishDigitsWithArabic)
    }
    @objc func handleTextChange(_ textChange: UITextField) {
        if emailTFOutlet.text?.count == 9 || emailTFOutlet.text?.count == 11 {
            emailTFOutlet.keyboardType = .numberPad
            emailTFOutlet.reloadInputViews() // need to reload the input view for this to work
        } else {
            emailTFOutlet.keyboardType = .default
            emailTFOutlet.reloadInputViews()
        }
        
    }
    //MARK:- CallBinging And Subscribing
    func callBingingAndSubscribing() {
        //emailTFOutlet.text = "momo@a.com"
        sbuscribeToEmailTFAndPasswordTF()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToAlert()
        //subscribeIsLoginEnabled()
        subscribeToLoginButton()
        subscribeToBackButton()
    }
}
//MARK:- End Class
