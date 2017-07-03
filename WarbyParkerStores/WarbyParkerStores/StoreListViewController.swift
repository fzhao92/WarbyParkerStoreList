//
//  ViewController.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let reuseId = "storeCell"

class StoreListViewController: UIViewController {
    
    var storeListViewModel: StoreListViewViewModel!
    
    lazy var storesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StoreCell.self, forCellReuseIdentifier: reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeListViewModel = StoreListViewViewModel(reloadTableViewCallback: {
            self.storesTableView.reloadData()
        })
        
        automaticallyAdjustsScrollViewInsets = false
        
        navigationController?.navigationBar.topItem?.title = storeListViewModel.title

        view.addSubview(storesTableView)
        storesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension StoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let storeCellViewModel = storeListViewModel.storeCellViewModel(forIndex: indexPath.row)
        let storeCellIndex = storeListViewModel.stores.index(of: storeCellViewModel.storeModel)!
        let storeCellIndexPath = IndexPath(row: storeCellIndex, section: 0)
        
        APIClient.downloadImage(forUrl: storeCellViewModel.imageUrl) { (image) in
            if let cell = tableView.cellForRow(at: storeCellIndexPath) as? StoreCell {
                DispatchQueue.main.async {
                    cell.update(withImage: image)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension StoreListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeListViewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? StoreCell else {
            fatalError("Cell is nil!")
        }
        
        cell.configure(withViewModel: storeListViewModel.storeCellViewModel(forIndex: indexPath.row))
        
        return cell
    }
    
}

