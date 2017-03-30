
import UIKit
import  UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        return true
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        // Do something serious in a real app.
        application.applicationIconBadgeNumber = 0
        print("Received Local Notification:")
    }
}
