//
//  NotificationViewController.swift
//  MyPets
//
//  Created by khacviet on 3/2/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationViewController: UIViewController {
    
    @IBOutlet weak var table_Notification: UITableView!
    @IBOutlet weak var btn_Done: UIButton!
    
    static let shareIstance = NotificationViewController()
    
    let database = DataBase.shareInstance
    var notifications = [Notification]()
    var pets = [Pet]()
    var notes = [Note]()
    
    var notifActions: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        pets = database.getPets()
        notes = database.getNote()
        
        let date = Date()
        for index in 0..<notes.count {
            if notes[index].time_note <= date {
                if notes[index].active == false {
                    notes[index].active = true
                    database.updateNote(id_note: Int64(index + 1), active: true)
                    database.addDataNotif(id_pet: notes[index].id_pet, notif_body: notes[index].text_note)
                }
            }
        } 
        
        notifications = database.getNotification()
        
        notifications = notifications.sorted(by: ({ $0.id_notif > $1.id_notif }))

        table_Notification.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pets = database.getPets()
        
        table_Notification.delegate = self
        table_Notification.dataSource = self
        
        let cellNotif = UINib(nibName: "NotificationsTableViewCell", bundle: nil)
        table_Notification.register(cellNotif, forCellReuseIdentifier: "NotificationsTableViewCell")
        
    }
    
    func getPetWithId(id: Int64) -> Pet? {
        for pet in pets {
            if pet.id == id {
                return pet
            }
        }
        return nil
    }

}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_Notification.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
        
        
        let id = notifications[indexPath.row].id_pet
        
           let pet = getPetWithId(id: id)
        
        
        cell.lbl_title.text = pet?.name
        
        cell.lbl_body.text = notifications[indexPath.row].notif_body
        
        
        
        cell.accessoryType = UITableViewCellAccessoryType.none
        
        
        
        
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.25
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.92, alpha: 1.0)
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if let notiView = table_Notification
            {
                let idDelete = notifications[indexPath.row].id_notif
                database.deleteDataNotifications(ID: idDelete)
                notifications.remove(at: indexPath.row)
                notiView.deleteRows(at: [indexPath], with: .fade)

                
            }
        }
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let id: Int = Int(notifications[indexPath.row].id_notif)
        let id = notifications[indexPath.row].id_pet
        let pet = getPetWithId(id: id)
        
        
        let alert = UIAlertController(title: "\((pet?.name)!)", message: "\(notifications[indexPath.row].notif_body)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        {
            (UIAlertAction) in
            self.notifActions = "OK"
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
        
        
        
        print(indexPath.row)
    }
}
