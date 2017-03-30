//
//  DataBase.swift
//  MyPets
//
//  Created by DuongIOS on 1/18/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//


import SQLite
class DataBase {
    
    private let id = Expression<Int64>("id")
    private let id_pet = Expression<Int64>("id_pet")
    
    private let pets = Table("PETS")
    private let name = Expression<String?>("name")
    private let kind = Expression<String?>("kind")
    private let gender = Expression<String?>("gender")
    private let dateOfBirtth = Expression<String?>("dateOfBirtth")
    private let petAvata = Expression<String?>("petAvata")
    
    private let petImages = Table("PETIMAGES")
    private let imagePath = Expression<String?>("imagePath")
    
    private let evens = Table("EVENS")
    private let date_even = Expression<String?>("date_even")
    private let text_even = Expression<String?>("text_even")
    private let image_videoPath = Expression<String?>("image_video")
    
    private let notes = Table("NOTES")
    private let time_note = Expression<Date?>("time_note")
    private let text_note = Expression<String?>("text_note")
    private let remind_note = Expression<Bool?>("remaid_note")
    private let active_note = Expression<Bool?>("active_note")
    
    private let notifications = Table("NOTIFICATION")
    private let notif_title = Expression<String?>("notif_title")
    private let notif_body = Expression<String?>("notif_body")
    
    //    private let nitifications = Table("NOTIFICATIONS")
    
    
    var path: String
    static let shareInstance = DataBase()
    private var db: Connection?
    
    private init() {
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        
        do {
            db = try Connection("\(path)/MyPets.sqlite3")
            
            createTablePets()
            createTableEven()
            createTableNote()
            createTableNotification()
            
            try db?.execute("PRAGMA foreign_keys = ON")     //De thuc thi duoc foreign key
            
            
            
        } catch {
            //db = nil
            print("Unable to open database")
        }
    }
    
    /*
     CREATE TABLE "PETS" (
     "id" INTEGER PRIMARY KEY NOT NULL,
     "name" TEXT,
     "dateOfBirtth" TEXT
     )
     */
    
        
    func convertName() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "yyyy-MM-dd' - 'HH:mm:ss"
        let now = dateformatter.string(from: NSDate() as Date)
        
        return now
    }
    
    
    func createTablePets(){
        do {
            try db!.run(pets.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(kind)
                table.column(gender)
                table.column(dateOfBirtth)
                table.column(petAvata)
            })
        } catch {
            print("Unable to create table Pets")
        }
    }
    
    func createTableEven() {
        do {
            try db!.run(evens.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(id_pet)
                table.column(date_even)
                table.column(text_even)
                table.column(image_videoPath)
                table.foreignKey(id_pet, references: pets, id, delete: .cascade)
            })
        } catch {
            print("Unable to create table Even")
        }
    }
    
    func createTableNote() {
        do {
            try db!.run(notes.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(id_pet)
                table.column(time_note)
                table.column(text_note)
                table.column(remind_note)
                table.column(active_note)
                table.foreignKey(id_pet, references: pets, id, delete: .cascade)
            })
        } catch {
            print("Unable to create table Milestone")
        }
    }
    
    func createTableNotification() {
        do {
            try db!.run(notifications.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(id_pet)
                table.column(notif_title)
                table.column(notif_body)
                table.foreignKey(id_pet, references: pets, id, delete: .cascade)
            })
        } catch {
            print("Unable to create table Notification")
        }
    }
    
    // #MARK: Add Data
    func addData(_ nameTable: Table, data: [Setter]) -> Int64? {
        do {
            let insert = nameTable.insert(data)
            let rowid = try db!.run(insert)
            return rowid
        } catch let err as NSError{
            print("Insert failed - \(err.localizedDescription)")
            return nil
        }
    }
    
    // #MARK: Get Data
    func getPets() -> [Pet] {
        var pets = [Pet]()
        do {
            for p in try db!.prepare(self.pets) {
                pets.append(Pet(id: p[id], name: p[name]!, kind: p[kind]!, gender: p[gender]!, dateOfBirth: p[dateOfBirtth]!, petAvata: p[petAvata]!))
            }
        } catch {
            print("Get failed")
        }
        return pets
    }
    
    func getImagePets(_ pid: Int64) -> [PetImage] {
        var petsImage = [PetImage]()
        do {
            for p in try db!.prepare(self.petImages.filter(id_pet == pid)) {
                petsImage.append(PetImage(id_image: p[id], id_pet: p[id_pet], imagePath: p[imagePath]!))
            }
        } catch {
            print("Get failed")
        }
        return petsImage
    }
    
    func getEven(_ pid: Int64) -> [Even] {
        var even = [Even]()
        do {
            for p in try db!.prepare(self.evens.filter(id_pet == pid)) {
                even.append(Even(id_even: p[id], id_pet: p[id_pet], date_even: p[date_even]!, text_even: p[text_even]!, image_videoPath: p[image_videoPath]!))
            }
        } catch {
            print("Get failed")
        }
        return even
    }
    
    func getNote() -> [Note] {
        var note = [Note]()
        do {
            for p in try db!.prepare(self.notes) {
                note.append(Note(id_note: p[id], id_pet: p[id_pet], time_note: p[time_note]!, text_note: p[text_note]!, remind: p[remind_note]!, active: p[active_note]!))
            }
        } catch {
            print("Get failed")
        }
        return note
    }
    
//    func getNoteActived(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    func getNotification() -> [Notification] {
        var notification = [Notification]()
        do {
            for p in try db!.prepare(self.notifications) {
                notification.append(Notification(id_notif: p[id], id_pet: p[id_pet], notif_body: p[notif_body]!))
            }
        } catch {
            print("Get failed")
            
        }
        return notification
    }
    
    // Add new pet
    func addDataPets(name: String, kind: String, gender: String, dateOfBirtth: String, petAvata: String) {
        let rowIdPets = addData(pets, data: [self.name <- name, self.kind <- kind, self.gender <- gender, self.dateOfBirtth <- dateOfBirtth, self.petAvata <- petAvata])
        
        print(rowIdPets!)
    }
    
    // Add new Note
    func addDataNote(id_pet: Int64, time: Date, text: String, remind: Bool, active: Bool) {
        let rowIdNote = addData(notes, data: [self.id_pet <- id_pet, self.time_note <- time, self.text_note <- text, self.remind_note <- remind, self.active_note <- active])
        
        print(rowIdNote!)
    }
    
    // Add new Even
    func addDataEven(id_pet: Int64, date_even: String, text_even: String, image_videoPath: String) {
        let rowIdEven = addData(evens, data: [self.id_pet <- id_pet, self.date_even <- date_even, self.text_even <- text_even, self.image_videoPath <- image_videoPath])
        
        print(rowIdEven!)
    }
    
    // Add Notification
    func addDataNotif(id_pet: Int64, notif_body: String) {
        let rowIdNotif = addData(notifications, data: [self.id_pet <- id_pet, self.notif_body <- notif_body])
    }
    
    
    
    
    // MARK: DELETE Data
    
    func deleteData(tableName: Table, id_data: Int64) {
        let delete = tableName.filter(id == id_data)
        do {
            if try (db?.run(delete.delete()))! > 0 {
                print("Deleted")
            } else {
                print("Delete not found")
            }
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func deleteDataNotes(ID: Int64) {
        //        let delete = self.delete(notes, ID: ID)
        _ = deleteData(tableName: notes, id_data: ID)
    }
    
    
    func deleteDataEvens(ID: Int64) {
        //        let delete = self.delete(evens, ID: ID)
        _ = deleteData(tableName: evens, id_data: ID)
    }
    
    func deleteDataNotifications(ID: Int64) {
        _ = deleteData(tableName: notifications, id_data: ID)
    }
    
    func deleteDataPets(ID: Int64) {
        
        let tablePets = pets.filter(id == ID)
        
        do {
            if try (db?.run(tablePets.delete()))! > 0 {
                print("Deleted Pets")
            } else {
                print("Delete not found Pets")
            }
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    // MARK: UPDATE Data
    func update(_ nameTable: Table, _ pid: Int64, data: [Setter]) {
        let tbl = nameTable.filter(id == pid)
        do {
            let update = tbl.update(data)
            try db!.run(update)
        } catch let err as NSError {
            print("Update failed - \(err.localizedDescription)")
        }
    }
    
    func updateNote(id_note: Int64, active: Bool) {
        let rowIdNote = update(notes, id_note, data: [self.active_note <- active])
        
        print("rowIdNote: \(rowIdNote)")
    }
    
    func updatePet(id: Int64 ,name: String, kind: String, gender: String, dateOfBirtth: String, petAvata: String) {
        let rowIdPet = update(pets, id, data: [self.name <- name, self.kind <- kind, self.gender <- gender, self.dateOfBirtth <- dateOfBirtth, self.petAvata <- petAvata])
        print("rowIdPet: \(rowIdPet)")
        
    }
    
    func updateEven(id_Even: Int64, id_pet: Int64, text_even: String) {
        let rowIdEven = update(evens, id_Even, data: [self.id_pet <- id_pet, self.text_even <- text_even])
        print("rowIdEven: \(rowIdEven)")
        
    }
    
    // Test Data Base
    //                        testDataBase()
    
    
    //            let vete = getVeterinary(1)
    //            print(vete.count)
    //            print(vete[0].name)
    //            print(vete[1].name)
    //            let vete2 = getVeterinary(2)
    //            print(vete2.count)
    //            print(vete2[0].name)
    
    
    //            let count = try db?.scalar(pets.count)
    //            print(count)
    //delete(petImages, ID: 1)
    
    //update(milestone, 1, data: [title <- "title2", note_milestone <- "note"])
    func testDataBase() {
        
        let namePet: [String] = ["Boby", "Jackey", "Pickman", "Tom", "Jerry", "Ben", "Maxian", "Rock"]
        let kindPet: [String] = ["Cat", "Dog", "Rabbit", "Hamster", "Bird", "Chicken"]
        let genderPet: [String] = ["Male", "Female"]
        let date: [String] = ["13-03-2015", "23-05-2016", "02-02-2014", "15-04-2016", "16-06-2013", "22-02-2016"]
        let text: [String] = ["Walk", "Visit Ha Long bay", "In the Air", "His Birth day"]
        let remind: [String] = ["0", "1"]
        
        for i in namePet {
            
            let randomKind: Int = Int(arc4random_uniform(UInt32(kindPet.count)))
            let randomGender: Int = Int(arc4random_uniform(UInt32(genderPet.count)))
            let randomDate: Int = Int(arc4random_uniform(UInt32(date.count)))
            let randomText: Int = Int(arc4random_uniform(UInt32(text.count)))
            let randomRemind: Int = Int(arc4random_uniform(UInt32(remind.count)))
            
            
            let testIdPet = addData(pets, data: [name <- "\(i)",kind <- "\(kindPet[randomKind])",gender <- "\(genderPet[randomGender])",dateOfBirtth <- "\(date[randomDate])",petAvata <- "2017-03-13T15:34:28"])
            
            let testIdImage = addData(petImages, data: [id_pet <- testIdPet!, imagePath <- "\(path)/Pug.jpg"])
            
            let testIdEven = addData(evens, data: [id_pet <- testIdPet!, date_even <- "\(date[randomDate])", text_even <- "\(text[randomText])", image_videoPath <- "2017-03-13T15:34:28"])
            
            
            var nRemaind: Bool
            if randomRemind == 1 {
                nRemaind = false
            } else { nRemaind = true }
            //            let testIdNote = addData(notes, data: [id_pet <- testIdPet!, time_note <- "\(date[randomDate])", text_note <- "\(text[randomText])", remind_note <- nRemaind])
        }
        
        
    }
}
