//
//  DeliveryAddressCell.swift
//  MVVM
//
//  Created by Ahmed on 6/2/21.
//

import UIKit

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
            //defultAddress.setTitle("✔️", for: .normal)
            defultAddress.setTitle("✓", for: .normal)
            defultAddress.setTitleColor(.black, for: .normal)
            
            defultAddress.layer.shadowColor = UIColor.black.cgColor
            defultAddress.layer.shadowOffset = CGSize(width: 0, height: 6)
            defultAddress.layer.shadowRadius = 8
            defultAddress.layer.shadowOpacity = 0.2
            defultAddress.layer.masksToBounds = false
            
            deleteAddress.layer.shadowColor = UIColor.black.cgColor
            deleteAddress.layer.shadowOffset = CGSize(width: 0, height: 6)
            deleteAddress.layer.shadowRadius = 8
            deleteAddress.layer.shadowOpacity = 0.2
            deleteAddress.layer.masksToBounds = false
        }else{
            defultAddress.setTitle("✓", for: .normal)
            defultAddress.setTitleColor(.white, for: .normal)
            
            defultAddress.layer.shadowColor = UIColor.black.cgColor
            defultAddress.layer.shadowOffset = CGSize(width: 0, height: 6)
            defultAddress.layer.shadowRadius = 8
            defultAddress.layer.shadowOpacity = 0.5
            defultAddress.layer.masksToBounds = false
            
            deleteAddress.layer.shadowColor = UIColor.black.cgColor
            deleteAddress.layer.shadowOffset = CGSize(width: 0, height: 6)
            deleteAddress.layer.shadowRadius = 8
            deleteAddress.layer.shadowOpacity = 0.5
            deleteAddress.layer.masksToBounds = false
        }
        addressLabel.text = address.address
        cityLabel.text = address.city
    }

}
