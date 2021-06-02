//
//  ShowMenuVC.swift
//  MVVM
//
//  Created by Ahmed on 6/1/21.
//

import UIKit
import RxCocoa
import RxSwift
import RSSelectionMenu

class ShowMenuVC: UIViewController {

    @IBOutlet weak var popUpMenuButtonOutlet: UIButton!
    @IBOutlet weak var backbuttonOutlet: UIButton!
    @IBOutlet weak var categoriesLabelOutlet: UILabel!
    @IBOutlet weak var addressButtonOutlet: UIButton!
    
    //dispose bag
    let disposeBag = DisposeBag()
    
    let simpleDataArray = ["Sachin", "Rahul", "Saurav", "Virat", "Suresh", "Ravindra", "Chris"]
    var simpleSelectedArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        popUpMenuButtonOutlet.pulsate()
        callBindAndSubscribtionFunction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        popUpMenuButtonOutlet.pulsate()
    }
    
    //MARK:- Call bind and subscribtion function
    func callBindAndSubscribtionFunction() {
        
        subscribeToPopUpMenuButton()
        subscribeToBackButton()
        subscribeToAddressButton()
        
    }
    
}
