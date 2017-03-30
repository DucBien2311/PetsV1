
import UIKit
import  UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
        }
        else{
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        }
    }
    
    @IBAction  func triggerNotification(){
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Elon said:", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello Tom！Get up, let's play with Jerry!", arguments: nil)
        content.sound = UNNotificationSound.default()
        // NSNumber类型数据
        content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1);
        content.categoryIdentifier = "com.elonchan.localNotification"
        // Deliver the notification in five seconds.
        /**** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'time interval must be at least 60 if repeating'*/
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }

    @IBAction func stopNotification(_ sender: AnyObject) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        // or you can remove specifical notification:
        // center.removePendingNotificationRequests(withIdentifiers: ["FiveSecond"])
    }
}


