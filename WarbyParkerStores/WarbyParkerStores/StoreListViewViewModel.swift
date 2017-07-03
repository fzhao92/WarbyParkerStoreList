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
    let numberOfSections = 1
    
    var cellsLoaded: Int {
        return stores.count
    }
    
    init(reloadTableViewCallback: @escaping () -> Void) {
        self.reloadTableViewCallback = reloadTableViewCallback
        retrieveData()
    }
    
    func retrieveData() {
        // - TODO: make api call to get stores
    }
    
    func numberOfItemsInSection() -> Int {
        return stores.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return numberOfSections
    }
    
    // - TODO: function to return tableview cell model for particular index
    
}
