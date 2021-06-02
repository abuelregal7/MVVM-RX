//
//  DeliveryAddressVC.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import UIKit
import RxCocoa
import RxSwift

class DeliveryAddressVC: UIViewController {

    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var newAddressButtonOutlet: UIBarButtonItem!
    
    var addressViewModel = DeliveryAddressViewModel()
    
    //dispose bag
    let disposeBag = DisposeBag()
    // cell identifire
    let addressTableViewCell = "DeliveryAddressCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addressTableView.rowHeight = 140
        callBindAndSubscribtionFunction()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAddress()
    }
    
    //MARK:- Call bind and subscribtion function
    func callBindAndSubscribtionFunction() {
        getAddress()
        bindToHiddenTable()
        subscribeToAlert()
        subscribeToResponse()
        subscribeToLoading()
        subscribeTonewAddressButton()
        subscribeToBackButton()
        subscribeToAlert()
    }
    
}
