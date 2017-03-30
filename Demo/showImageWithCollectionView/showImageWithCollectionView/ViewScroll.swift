//
//  ViewScroll.swift
//  showImageWithCollectionView
//
//  Created by Nhật Minh on 2/8/17.
//  Copyright © 2017 khacviet. All rights reserved.
//

import UIKit



class ViewScroll: UIViewController{
    var customScrollView: CustomScrollView!
    var customCollectionView: CustomCollectionView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customScrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 30))
        self.view.addSubview(customScrollView)
      customCollectionView = CustomCollectionView(frame: CGRect(x: 0, y: self.view.bounds.size.height - 30, width: self.view.bounds.size.width, height: 30))
        customCollectionView.delegate = self
        self.view.addSubview(customCollectionView)
        
    }
    
    
    
}
extension ViewScroll: ScrollDelegate{
    func selectedImage(pageControlCurrentPage: Int, scrollViewContentOffSet: CGPoint) {
        self.customScrollView.pageControl.currentPage = pageControlCurrentPage
        self.customScrollView.scrollView.contentOffset = scrollViewContentOffSet
    }
    
    func scrollCollectionView(scrollViewContentOffSet: CGPoint) {
        self.customScrollView.scrollView.contentOffset = scrollViewContentOffSet
    }
    
    
}








