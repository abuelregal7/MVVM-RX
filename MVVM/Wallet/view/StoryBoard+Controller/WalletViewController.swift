//
//  WalletViewController.swift
//  MVVM
//
//  Created by Ahmed on 5/2/21.
//
//MARK:- Start Of Class

import UIKit
import RxCocoa
import RxSwift

//MARK:- Walet ViewController Class
class WalletViewController: UIViewController {
    
    //properties outlet
    @IBOutlet weak var walletTableView: UITableView!
    
    @IBOutlet weak var walletContainerView: UIView!
    // cell identifire
    let walletTableViewCell = "WalletTableViewCell"
    
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var profileButtonOutlet: UIBarButtonItem!
    
    
    //instance of viewModel
    var walletViewModel = WalletViewModel()
    //dispose bag
    let disposeBag = DisposeBag()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //call Functions
        setUpTableView()
        callBingingAndSubscribing()
        
    }
    
    //MARK:- CallBinging And Subscribing
    func callBingingAndSubscribing() {
        bindToHiddenTable()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToWalletSelection()
        getWallet()
        subscribeToBackButton()
        subscribeToProfileButton()
    }
    //MARK:- Set Up TableView
    func setUpTableView() {
//        walletTableView.dataSource  = self
//        walletTableView.delegate    = self
    }
    
}
//MARK:- End Of Class
