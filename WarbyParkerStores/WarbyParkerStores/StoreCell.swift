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
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.isHidden = false
        return indicator
    }()
    
    lazy var opacityMask: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.15, green:0.65, blue:0.87, alpha:0.7)
        view.isHidden = true
        return view
    }()
    
    var opacityMaskWidthConstraint: Constraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        backgroundColor = UIColor(red:0.15, green:0.65, blue:0.87, alpha:1.0)
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(photoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.height.equalTo(contentView).dividedBy(2)
        }
        
        contentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(photoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        contentView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(photoImageView)
        }
        
        contentView.addSubview(opacityMask)
        opacityMask.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalTo(contentView)
            self.opacityMaskWidthConstraint = make.width.equalTo(0).constraint
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
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
    }
    
    func update(withImage image: UIImage?) {
        if let image = image {
            loadingIndicator.stopAnimating()
            photoImageView.image = image
        } else {
            loadingIndicator.startAnimating()
            photoImageView.image = nil
        }
    }
    
    func executeAnimation(completion: @escaping () -> Void) {
        opacityMask.isHidden = false
        
        if let widthConstraint = opacityMaskWidthConstraint {

            widthConstraint.update(offset: contentView.frame.width)
            
            UIView.animate(withDuration: 0.8, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: { (_) in
                self.opacityMask.isHidden = true
                self.opacityMaskWidthConstraint?.update(offset: 0)
                completion()
            })
            
        }
        
    }

}
