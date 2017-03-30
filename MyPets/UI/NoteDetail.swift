//
//  NoteDetail.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import UserNotifications

class NoteDetail: UIViewController {


    @IBOutlet weak var btnSelectNamePets: UIButton!
    @IBOutlet weak var tfDateTime: UITextField!
    @IBOutlet weak var datetimePicker: UIDatePicker!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var switchRemind: UISwitch!

    var deadline = Date()
    var dateFormatter: DateFormatter!
    var selectedName: DropdownNamePets!

    let database = DataBase.shareInstance
    var pets = [Pet]()
    var idPetChosse: Int = 0






    override func viewDidLoad() {
        super.viewDidLoad()

        tfDateTime.isUserInteractionEnabled = false
        setButtonForRightBarNavi()
        setButtonSelectNamePets()

        pets = database.getPets()

    }

    func setButtonForRightBarNavi()  {
        self.title = "Note Detail"
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
    }
    func checkNull() -> Bool {
        if tfDateTime.text == "" || tfNote.text == "" || (btnSelectNamePets.titleLabel?.text)! == "Select Name Pets" {
            let alert = UIAlertController(title: "Warning", message: "You must enter content note & date time, name pet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return true
        } else {
            return false
        }

    }

    func save() {
        if checkNull() == true {
            checkNull()
        }
        else
        {
            database.addDataNote(id_pet: Int64(idPetChosse), time: datetimePicker.date, text: tfNote.text!, remind: (switchRemind.isOn), active: false)

            checkRemindSwitch()
            self.navigationController?.popViewController(animated: true)
        }
    }

    func setButtonSelectNamePets() {
        btnSelectNamePets.layer.cornerRadius = 5
        btnSelectNamePets.layer.borderWidth = 0.1
    }

    @IBAction func selectNameAction(_ sender: UIButton) {
        selectedName = DropdownNamePets(frame: CGRect(x: btnSelectNamePets.center.x - (btnSelectNamePets.bounds.size.width / 2),
                                                      y: btnSelectNamePets.center.y + (btnSelectNamePets.bounds.size.height / 2),
                                                      width: btnSelectNamePets.bounds.size.width,
                                                      height: btnSelectNamePets.bounds.size.height * 3))
        selectedName.delegate = self
        self.view.addSubview(selectedName)
        selectedName.addTableView()
    }
    @IBAction func date_time_picker_values_change_action(_ sender: UIDatePicker) {
        setDateTime()
        tfDateTime.text = dateFormatter.string(from: sender.date)
    }

    func setDateTime() {
        datetimePicker.datePickerMode = UIDatePickerMode.dateAndTime
        self.view.addSubview(datetimePicker)
        datetimePicker.addTarget(self, action: #selector(NoteDetail.date_time_picker_values_change_action(_:)), for: UIControlEvents.valueChanged)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
    }

    // Push Notification
    func checkRemindSwitch() {
        if switchRemind.isOn == true{
            notification()

        } else {
            print("Remind: OFF")
        }
    }

    func notification() {

        let datePicker = datetimePicker.date
        let application = UIApplication.shared
        let title = (btnSelectNamePets.titleLabel?.text!)!
        let notiBody = tfNote.text!

        //        if #available(iOS 10.0, *) {
        //
        //            let newComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: datePicker)
        //
        //            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
        //
        //            let content = UNMutableNotificationContent()
        //            content.title = NSString.localizedUserNotificationString(forKey: "\(title):", arguments: nil)
        //            content.body = NSString.localizedUserNotificationString(forKey: "\(notiBody)", arguments: nil)
        //            content.sound = UNNotificationSound.default()
        //
        //            Notification.sharedInstance.badge = Notification.sharedInstance.badge + 1
        //            content.badge = NSNumber(integerLiteral: Notification.sharedInstance.badge)
        //
        //            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        //
        ////  let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        //
        //            let request = UNNotificationRequest(identifier: "Notifications\(arc4random_uniform(100))", content: content, trigger: trigger) //tìm giải pháp thay thế arc4random.
        //
        //
        //
        //            center.add(request, withCompletionHandler: nil)
        //        }
        //        else {







        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        let notification = UILocalNotification()
        notification.fireDate = datePicker //NSDate.init(timeIntervalSinceNow: 5) as Date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.alertTitle = btnSelectNamePets.titleLabel?.text
        notification.alertBody = tfNote.text
        
        Notification.sharedInstance.badge = Notification.sharedInstance.badge + 1
        notification.applicationIconBadgeNumber = Notification.sharedInstance.badge
        
        notification.alertAction = "open"
        notification.hasAction = true
        notification.userInfo = ["UUID": "reminderID" ]
        UIApplication.shared.scheduleLocalNotification(notification)
        //        }
    }

   

    //---------------------------------------------------------------------------------------------------------------
}
//
//extension AppDelegate: UNUserNotificationCenterDelegate{
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        let vc = NotificationViewController(nibName: "NotificationViewController", bundle: Bundle.main)
//
//        if self.window?.rootViewController != nil
//        {
//            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
//            vc.btn_Done.isHidden = false
//        }
//    }
//}




extension NoteDetail: ChooseNameDelegate {
    func chooseNamePets(index: Int) {
        idPetChosse = index + 1
        setNameButtonTitle(name: pets[index].name)
    }
    func setNameButtonTitle(name: String) {
        btnSelectNamePets.setTitle(name, for: .normal)
        btnSelectNamePets.setTitleColor(UIColor.white, for: .normal)
        btnSelectNamePets.titleLabel?.textAlignment = .center
        btnSelectNamePets.backgroundColor = UIColor.orange
        selectedName.tableView.isHidden = true
    }
}
