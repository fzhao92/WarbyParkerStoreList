//
//  StoreDetailViewController.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

class StoreDetailViewController: UIViewController {
    
    lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.isHidden = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(heroImageView)
        heroImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(heroImageView.snp.width)
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(heroImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(heroImageView)
        }
        
    }
    
    func configure(withViewModel viewModel: StoreDetailViewModel) {
        
        loadingIndicator.startAnimating()
        
        let placeHolderImage = #imageLiteral(resourceName: "warby_redit-1")
        
        if let urlStr = viewModel.heroImageUrl {
            let url = URL(string: urlStr)!
            heroImageView.af_setImage(withURL: url, placeholderImage: placeHolderImage, completion: { (_) in
                self.loadingIndicator.stopAnimating()
            })
        } else {
            heroImageView.image = placeHolderImage
            loadingIndicator.stopAnimating()
        }
        
        addressLabel.text = viewModel.address
        descriptionLabel.text = viewModel.description
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
