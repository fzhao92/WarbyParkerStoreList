//
//  StoreCell.swift
//  WarbyParkerStores
//
//  Created by Forrest Zhao on 7/2/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

class StoreCell: UITableViewCell {
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    lazy var nameLabel: UILabel = {
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(contentView).offset(5)
            make.width.equalTo(contentView).dividedBy(4)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(photoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.height.equalTo(contentView).dividedBy(2)
        }
        
        contentView.addSubview(addressLabel)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(photoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(10)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(withImage: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: StoreCellViewModel) {
        // - TODO: update labels' text with viewModel properties
    }
    
    private func update(withImage image: UIImage?) {
        if let image = image {
            loadingIndicator.stopAnimating()
            photoImageView.image = image
        } else {
            loadingIndicator.startAnimating()
            photoImageView.image = nil
        }
    }

}
