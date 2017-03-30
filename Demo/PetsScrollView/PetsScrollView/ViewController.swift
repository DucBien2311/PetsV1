//
//  ViewController.swift
//  PetsScrollView
//
//  Created by Nhật Minh on 2/6/17.
//  Copyright © 2017 Nhật Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    var colors : [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl = UIPageControl()
    var pageImages: [String] = [] // chứa tên ảnh
    var photo: [UIImageView] = [] // chứa ảnh để trả về lúc zoom
    var frontScrollViews: [UIScrollView] = [] // scrollView con để zoom không bị lỗi
    var currentPage = 0 // để lúc bật lên sẽ ở trang đầu tiên của scrollView
    var first = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["meo1", "meo2", "meo3"]
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        self.scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        configurePageControl()
        pageControl.addTarget(self, action: #selector(changePage), for: UIControlEvents.valueChanged)
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
    }
    
    override func viewDidLayoutSubviews() {
        if !first
        {
            first = true
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(pageImages.count) , height: 0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            for i in 0..<pageImages.count
            {
                let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
                photo.append(imgView)
                let frontScrollView = UIScrollView(frame: CGRect( x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.scrollView.addSubview(frontScrollView)
            }
        }
    }
    
    func configurePageControl()
    {
        self.pageControl.frame = CGRect(x: 0, y: self.view.bounds.size.height - 50, width: self.view.bounds.width, height: 50)
        self.pageControl.numberOfPages = pageImages.count
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    func changePage(sender: UIPageControl) -> ()
    {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    func tapImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: photo[pageControl.currentPage])
        zoomRectForScale(frontScrollViews[pageControl.currentPage].zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(_ gesture: UITapGestureRecognizer)
    {
        if frontScrollViews[pageControl.currentPage].zoomScale > frontScrollViews[pageControl.currentPage].minimumZoomScale
        {
            let position = gesture.location(in: photo[pageControl.currentPage])
            zoomRectForScale(frontScrollViews[pageControl.currentPage].zoomScale * 0.5, center: position)
        }
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)
    {
        
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollViews[pageControl.currentPage].zoom(to: zoomRect, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return photo[pageControl.currentPage]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

