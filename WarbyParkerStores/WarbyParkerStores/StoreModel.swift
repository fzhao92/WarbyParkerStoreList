//
//  Store.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address {
    
    let regionCode: String
    let regionName: String
    let extendedAddress: String
    let locality: String
    let postalCode: String
    let countryCode: String
    let streetAddress: String
    
    init(dict: JSON) {
        regionCode = dict["region_code"].stringValue
        regionName = dict["region_name"].stringValue
        extendedAddress = dict["extended_address"].stringValue
        locality = dict["locality"].stringValue
        postalCode = dict["postal_code"].stringValue
        countryCode = dict["country_code"].stringValue
        streetAddress = dict["street_address"].stringValue
    }
    
}

struct StoreModel {
    
    let name: String
    let address: Address
    let cardPhotoUrl: String
    let heroImageUrls: [String]
    
    init(dict: JSON) {
        name = dict["name"].stringValue
        address = Address(dict: dict["address"])
        cardPhotoUrl = dict["cms_content"]["card_photo"].stringValue
        
        var urls = [String]()
        for json in dict["cms_content"]["opening_soon"]["hero"]["images"].arrayValue {
            urls.append(json["url"].stringValue)
        }
        heroImageUrls = urls
    }
    
}
