//
//  AddNewAddressVC.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import UIKit
import RxCocoa
import RxSwift

class AddNewAddressVC: UIViewController {
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    //dispose bag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        subscribeToBackButton()
    }
    

    //MARK:- Subscribe To Back Button
    func subscribeToBackButton() {
        backButtonOutlet
            .rx
            .tap
            .subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
                print("buttonTapped")
                self.dismiss(animated: true, completion: nil)
                
            }).disposed(by: disposeBag)
    }

}
