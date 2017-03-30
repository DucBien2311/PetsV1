//
//  Images.swift
//  showImageWithCollectionView
//
//  Created by Nhật Minh on 2/8/17.
//  Copyright © 2017 khacviet. All rights reserved.
//

import UIKit

class Images { // for sharing images
    static let sharedInstance = Images()
    private init() {}
    
    var clickedImage: CGFloat!
    
    var cells: [UIImage]!
    
    init(clickedImage: CGFloat, cells: [UIImage]) {
        self.clickedImage = clickedImage
        self.cells = cells
    }
}
