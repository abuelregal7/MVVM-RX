//
//  PickerModel.swift
//  MVVM
//
//  Created by Ahmed on 5/25/21.
//

import Foundation

struct PickerModel {
    let name: String?
    
    static func fetchNames() -> [PickerModel]
    {
        return [
            PickerModel(name: "ahmed"),
            PickerModel(name: "mohamed"),
            PickerModel(name: "ramy"),
            PickerModel(name: "esmael"),
            PickerModel(name: "khloud"),
            PickerModel(name: "manar"),
            PickerModel(name: "amira"),
            PickerModel(name: "amgad"),
            PickerModel(name: "noor"),
            
        ]
    }
    
}
