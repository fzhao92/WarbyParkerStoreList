//
//  StoreDetailViewModel.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

struct StoreDetailViewModel {
    
    let storeModel: StoreModel
    
    init(model: StoreModel) {
        storeModel = model
    }
    
    var heroImageUrl: String? {
        return storeModel.heroImageUrl
    }
    
    var offersEyeExams: Bool {
        return storeModel.offersEyeExams
    }
    
    var description: String {
        return storeModel.description
    }
    
    var address: String {
        
        let countryName: String
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: storeModel.address.countryCode) {
            countryName = name
        } else {
            //invalid country code
            countryName = storeModel.address.countryCode
        }
        
        return "\(storeModel.address.streetAddress), \(storeModel.address.locality), \(storeModel.address.regionName) \(storeModel.address.postalCode), \(countryName)"
    }
    
}
