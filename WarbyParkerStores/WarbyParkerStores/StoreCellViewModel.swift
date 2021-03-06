//
//  StoreCellViewModel.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

struct StoreCellViewModel {
    
    let storeModel: StoreModel
    
    init(model: StoreModel) {
        storeModel = model
    }
    
    var name: String {
        return storeModel.name
    }
    
    var address: String {
        let addressStr = "\(storeModel.address.locality), \(storeModel.address.regionName)"
        return addressStr
    }
    
    var imageUrl: String {
        return storeModel.cardPhotoUrl
    }
    
}
