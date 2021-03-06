//
//  SplashVC.swift
//  MVVM
//
//  Created by Ahmed on 5/24/21.
//

import UIKit
import RxCocoa
import RxSwift

//MARK:- SplashVC
class SplashVC: UIViewController {

    @IBOutlet weak var goToLoginOutlet: UIButton!
    
    //disposeBag
    let disposeBag = DisposeBag()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        goToLoginOutlet.layer.masksToBounds = false
        subscribeToGoLoginButton()
    }
    //MARK:- SubscribeToGoLoginButton
    func subscribeToGoLoginButton() {
        goToLoginOutlet
            .rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("buttonTapped")
                self.goToLoginOutlet.shake()
                if let walletVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                    let navController = UINavigationController(rootViewController: walletVC)
                    navController.isNavigationBarHidden = true
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                }
            }).disposed(by: disposeBag)
    }
}
//MARK:- End Of Class
