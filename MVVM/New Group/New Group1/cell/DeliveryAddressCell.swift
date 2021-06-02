//
//  DeliveryAddressCell.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import UIKit
import RxCocoa
import RxSwift

class DeliveryAddressCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var deleteAddress: UIButton!
    @IBOutlet weak var defultAddress: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(address: AddressData) {
        if address.set_default == 0 {
            defultAddress.setTitle("✔️", for: .normal)
        }else{
            defultAddress.setTitle("✓", for: .normal)
        }
        addressLabel.text = address.address
        cityLabel.text = address.city
    }

}
