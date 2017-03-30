//
//  HomeViewController.swift
//  MyPets
//
//  Created by Tuuu on 1/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var table_Notes: UITableView!
    
    let database = DataBase.shareInstance
    
    fileprivate var notes = [Note]()
    fileprivate var pets = [Pet]()
    
    var actions : String?
    
    var app:UIApplication = UIApplication.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_Notes.delegate = self
        table_Notes.dataSource = self
        let cellNote = UINib(nibName: "CellNotes", bundle: nil)
        table_Notes.register(cellNote, forCellReuseIdentifier: "CellNote")
        
        notes = database.getNote()
        pets = database.getPets()
        
        setButtonForRightBarNavi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notes = database.getNote()
        pets = database.getPets()
        
        notes = notes.sorted(by: ({ $0.id_note > $1.id_note }))
        
        table_Notes.reloadData()
    }
    
    func setButtonForRightBarNavi(){
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func add(){
        
        let viewNoteDetail = NoteDetail(nibName: "NoteDetail", bundle: Bundle.main)
        self.navigationController?.pushViewController(viewNoteDetail, animated: true)
    }

    
    func notifDelete(index: Int)  {
        
        let date: Date = notes[index].time_note
        
        print(date)
    
        let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
        
        guard scheduledNotifications != nil else {return} // Nothing to remove, so return

        for notification in scheduledNotifications! { // loop through notifications...
          
            print(notification)
            
            if (notification.fireDate == date) { // ...and cancel the notification that corresponds to this TodoItem instance (matched
                UIApplication.shared.cancelLocalNotification(notification) // there should be a maximum of one match on UUID
              
                print(scheduledNotifications!.count)
                break
            }
        }
    }
}



extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_Notes.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! CellNotes
        
        let id: Int = Int(notes[indexPath.row].id_pet)
        cell.lbNamePet.text = pets[id - 1].name
        cell.contentNotes.text = notes[indexPath.row].text_note
         let date = notes[indexPath.row].time_note
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        let textOfTime = dateFormater.string(from: date)
 
        cell.lbDate.text = textOfTime
        
        var nCheck: String
        if notes[indexPath.row].remind == true {
            nCheck = "Yes"
        } else { nCheck = "No" }
        cell.lbRemind.text = nCheck
        
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.layer.shadowColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        
        //        cell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if let noteView = table_Notes
            {
                notifDelete(index: indexPath.row)

                
                let idDelete = notes[indexPath.row].id_note
                database.deleteDataNotes(ID: idDelete)
                notes.remove(at: indexPath.row)
                noteView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let id: Int = Int(notes[indexPath.row].id_pet)
        
        let alert = UIAlertController(title: "\(pets[id - 1].name)", message: "\(notes[indexPath.row].text_note)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        {
            (UIAlertAction) in
            self.actions = "OK"
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
}
