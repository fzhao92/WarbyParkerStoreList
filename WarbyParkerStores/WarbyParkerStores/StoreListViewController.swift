//
//  ViewController.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class StoreListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getListOfStores { (stores) in
            print(stores)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

