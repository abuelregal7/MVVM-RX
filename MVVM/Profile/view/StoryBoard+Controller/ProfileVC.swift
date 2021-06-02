//
//  ProfileVC.swift
//  MVVM
//
//  Created by Ahmed on 5/24/21.
//

import UIKit
import RxCocoa
import RxSwift

//MARK:- ProfileVC
class ProfileVC: UIViewController {
    
    @IBOutlet weak var idLabelOutlet: UILabel!
    @IBOutlet weak var creatAtLabelOutlet: UILabel!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var pickerButtonOutlet: UIButton!
    @IBOutlet weak var textFieldOutlet: UITextField!
    let pickerView = UIPickerView()
    
    //instance of viewModel
    var profileViewModel = ProfileViewModel()
    
    //dispose bag
    let disposeBag = DisposeBag()
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
    
    let items2 = Observable.just(PickerModel.fetchNames())
    
    var data = PickerModel.fetchNames()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        pickerButtonOutlet.flash()
        callBingingAndSubscribing()
        setUp()
    }
    
    //MARK:- SetUp
    func setUp() {
        textFieldOutlet.layer.masksToBounds = false
        pickerButtonOutlet.layer.masksToBounds = false
        textFieldOutlet.inputView = pickerView
    }
    
    //MARK:- CallBinging And Subscribing
    func callBingingAndSubscribing() {
        subscribeToBackButton()
        subscribeToLoading()
        getUser()
        bindToTextField()
        sbuscribeToNameTF()
        subscribeToResponse()
        subscribeToPickerButton()
        subscribeToResponsePicker()
    }
    
}
//MARK:- End Of Class
