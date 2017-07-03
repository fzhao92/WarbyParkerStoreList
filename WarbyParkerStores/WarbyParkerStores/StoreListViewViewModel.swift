//
//  StoreListViewViewModel.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class StoreListViewViewModel {
    
    var reloadTableViewCallback: () -> Void
    var stores = [StoreModel]()
    private let numberOfSections = 1
    
    let title = "Warby Parker Stores"
    
    init(reloadTableViewCallback: @escaping () -> Void) {
        self.reloadTableViewCallback = reloadTableViewCallback
        retrieveData()
    }
    
    func retrieveData() {
        APIClient.shared.getListOfStores { (storeList) in
            if let storeList = storeList {
                self.stores = storeList
                self.reloadTableViewCallback()
            }
        }
//        APIClient.getListOfStores { (storeList) in
//            if let storeList = storeList {
//                self.stores = storeList
//                self.reloadTableViewCallback()
//            }
//        }
    }
    
    func numberOfItemsInSection() -> Int {
        return stores.count
    }
    
    func numberOfRowsInSection() -> Int {
        return stores.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return numberOfSections
    }
    
    func storeCellViewModel(forIndex index: Int) -> StoreCellViewModel {
        return StoreCellViewModel(model: stores[index])
    }
    
}
