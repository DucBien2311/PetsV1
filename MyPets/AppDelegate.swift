//
//  AppDelegate.swift
//  MyPets
//
//  Created by Tuuu on 1/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//KhacViet

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainTabBarVC: MainTabBarViewController?

    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerNotification()

        _ = DataBase.shareInstance
        
        if !UserDefaults.standard.bool(forKey: "LaunchIntroduce") {
            UserDefaults.standard.set(false, forKey: "LaunchIntroduce")
        }
        
        isFirstLaunch()
        
        if checkFolderExist(path: directoryPath) == true {
            creatPetsFolder()
            creatTimeLineFolder()
        }

        if let localNotification = launchOptions?[UIApplicationLaunchOptionsKey.location] as? UILocalNotification{
            if let userInfo = localNotification.userInfo{
                UIAlertView(title: "Local Notification", message: userInfo["msg"] as? String, delegate: nil, cancelButtonTitle: "OK").show()
            }
        }

        if launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil {

        }

        return true
    }
    
    func registerNotification() {
        let notificationSettings = UIUserNotificationSettings.init(types: [.sound, .alert, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("AAAAAAAAAAAA")

    }
    
    
    
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        print(notification.userInfo)
        
//        var topController : UIViewController = (application.keyWindow?.rootViewController)!
//
//        while ((topController.presentedViewController) != nil) {
//
//            topController = topController.presentedViewController!
//        }
//
//        let alert = UIAlertController(title: "", message: notification.alertBody, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in}))
//        topController.present(alert, animated: true, completion: nil)
    }

    
    
    
    
    
    func creatPetsFolder() {
        let petsFolder = kPets
        do {
            try FileManager.default.createDirectory(atPath: petsFolder, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }

    }

    func creatTimeLineFolder() {
        let petsTimeline = kTimelines
        do {
            try FileManager.default.createDirectory(atPath: petsTimeline, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }

    func checkFolderExist(path: String) -> Bool{
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            return true
        }
        else {
            return false
        }
    }

        func isFirstLaunch()
        {
            let check = UserDefaults.standard.object(forKey: "LaunchIntroduce") as? Bool
            print(check!)
            if UserDefaults.standard.bool(forKey: "LaunchIntroduce")
            {
                let introduceView = IntroduceApp(nibName: "IntroduceApp", bundle: nil)
                window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = introduceView
                window?.makeKeyAndVisible()
                //First time
            }
            else
            {
//                showAlert()

                let mainTabBarVC = MainTabBarViewController(nibName: "MainTabBarViewController", bundle: nil)
                window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = mainTabBarVC
                window?.makeKeyAndVisible()

                //Not first time
            }

        }

//    func showAlert () {
//         let alert = UIAlertController(title: "View Tutorial", message: "Do you want view the tutorial again?", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
//        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
//        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//    }


    func applicationWillResignActive(_ application: UIApplication) { //1.0
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {//1.1
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {//2.0
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //Được gọi là một phần của quá trình chuyển đổi từ nền sang trạng thái hoạt động; Ở đây bạn có thể hoàn tác nhiều thay đổi được thực hiện khi nhập nền

        application.applicationIconBadgeNumber = 0
        Notification.sharedInstance.badge = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {//2.1
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //Khởi động lại bất kỳ tác vụ nào đã bị tạm dừng (hoặc chưa bắt đầu) trong khi ứng dụng không hoạt động. Nếu ứng dụng trước đây là nền, hãy tùy chọn làm mới giao diện người dùng.
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {

        if self.window?.rootViewController != nil
        {
            print(notification.userInfo)
            (self.window?.rootViewController as! UITabBarController).selectedIndex = 2
        }
    }
}
