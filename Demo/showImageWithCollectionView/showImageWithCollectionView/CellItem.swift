//
//  CellItem.swift
//  showImageWithCollectionView
//
//  Created by Nhật Minh on 2/13/17.
//  Copyright © 2017 khacviet. All rights reserved.
//

import UIKit

class CellItem: UICollectionViewCell {
    var imageView: UIImageView!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func addSubViews() {
        if (imageView == nil)
        {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 37.5, height: 30))
            imageView.layer.borderColor = tintColor.cgColor
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    
    
    
    
    
    
    
    
    
}
