//
//  MainTabBarViewController.swift
//  MyPets
//
//  Created by Tuuu on 1/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    var notesVC: NotesViewController?
    var petsVC: PetsViewController?
    var notificationsVC: NotificationViewController?
    var aboutVC: AboutViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [setupNotesView(), setupPetsView(), setupNotificationView(), setupAboutView()]
        tabBar.barTintColor = UIColor(red: 0.97, green: 0.48, blue: 0.15, alpha: 1.0)
        tabBar.tintColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupNotesView() -> MyPetsNavigationController{
        let noteVC = NotesViewController(nibName: "NotesViewController", bundle: nil)

        noteVC.title = "Notes"
        self.notesVC = noteVC
        
        let nNoteVC = MyPetsNavigationController(rootViewController: noteVC)
        let homeVCBarItem = UITabBarItem(title: "NOTES", image: UIImage(named: "note.png"), selectedImage: UIImage(named: "selectedImage.png"))
        nNoteVC.tabBarItem = homeVCBarItem
        
        return nNoteVC
    }
    
    func setupPetsView() -> MyPetsNavigationController{
        let petsVC = PetsViewController(nibName: "PetsViewController", bundle: nil)
        petsVC.title = "Pets"
        self.petsVC = petsVC
        
        let nPetsVC = MyPetsNavigationController(rootViewController: petsVC)
        let petsVCBarItem = UITabBarItem(title: "PETS", image: UIImage(named: "pet.png"), selectedImage: UIImage(named: "selectedImage.png"))
        nPetsVC.tabBarItem = petsVCBarItem
        return nPetsVC
    }
    
    func setupNotificationView() -> MyPetsNavigationController {
        let notificationsVC = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notificationsVC.title = "Notifications"
        self.notificationsVC = notificationsVC
        
        let nNotificationsVC = MyPetsNavigationController(rootViewController: notificationsVC)
        let notificationsVCBarItem = UITabBarItem(title: "NOTIFICATIONS", image: UIImage(named: "notifications.png"), selectedImage: UIImage(named: "selectedImage.png"))
        nNotificationsVC.tabBarItem = notificationsVCBarItem
        
        return nNotificationsVC
    }

    func setupAboutView() -> MyPetsNavigationController {
        let aboutVC = AboutViewController(nibName: "AboutViewController", bundle: nil)
        aboutVC.title = "Abouts"
        self.aboutVC = aboutVC

        let nAboutsVC = MyPetsNavigationController(rootViewController: aboutVC)
        let aboutsVCBarItem = UITabBarItem(title: "ABOUT", image: UIImage(named: "about.png"), selectedImage: UIImage(named: "selectedImage.png"))
        nAboutsVC.tabBarItem = aboutsVCBarItem

        return nAboutsVC
    }
}
