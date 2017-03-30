//
//  TutorialMyPets.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/24/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class IntroduceApp: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageController: UIPageControl!

    var photo: [UIImageView] = []
    var pageImages: [String] = []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    var window: UIWindow?

    override func viewDidLoad() {

        super.viewDidLoad()

        pageImages = ["Wellcome", "CreatNote", "Notes", "NoteEdit", "AddPet", "MainPets", "EditPets", "Notifications", "PetsGettingStarted"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        scrollView.delegate = self
        
    }

    override func viewDidLayoutSubviews() {
        if (!first)
        {
            first = true
            let pageScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pageScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            for i in 0..<pageImages.count
            {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".png"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true


                let frontScrollView = UIScrollView(frame: CGRect(x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))

                frontScrollView.delegate = self
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.scrollView.addSubview(frontScrollView)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
        if pageNumber == (CGFloat(pageImages.count) - 1) {
            getStarting(change: 0)
        }else {
            getStarting(change: 1)
        }
    }

    func getStarting(change: Int) {
        if change == 0
        {
            editButton()
        }
        else
        {
            for view in self.view.subviews{
                if view is UIButton
                {
                    view.removeFromSuperview()
                }
            }
        }
    }

    func editButton() {
        let btnGettingStarted = UIButton(frame: CGRect(x: self.view.bounds.size.width/2 - ((self.view.bounds.size.width/3)/2), y: self.view.bounds.size.height/2 - ((self.view.bounds.size.width/3)/2), width: self.view.bounds.size.width/3, height: 50))
        btnGettingStarted.setTitle("Getting Started", for: .normal)
        btnGettingStarted.setTitleColor(UIColor.white, for: .normal)
        btnGettingStarted.backgroundColor = UIColor(red: 0.97, green: 0.48, blue: 0.15, alpha: 1.0)
        btnGettingStarted.layer.borderWidth = 0.2
        btnGettingStarted.layer.borderColor = UIColor.orange.cgColor
        btnGettingStarted.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        btnGettingStarted.layer.shadowOpacity = 1.0
        btnGettingStarted.layer.shadowRadius = 2
        btnGettingStarted.layer.cornerRadius = 8
        btnGettingStarted.layer.masksToBounds = true
        btnGettingStarted.addTarget(self, action: #selector(start), for: .touchUpInside)
        self.view.addSubview(btnGettingStarted)
    }

    func start() -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let VC = MainTabBarViewController(nibName: "MainTabBarViewController", bundle: nil)
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
        UserDefaults.standard.set(false, forKey: "LaunchIntroduce")
        return true
    }


    @IBAction func onChange(_ sender: UIPageControl) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage) * scrollView.frame.size.width, y: 0)
    }
    
}
