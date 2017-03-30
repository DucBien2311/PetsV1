//
//  AddEven.swift
//  MyPets
//
//  Created by khacviet on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class AddEven: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tfCaption: UITextField!
    @IBOutlet weak var photoPicker: UIImageView!
    
    static let shareInstance = AddEven()
    
    var idEvenChanging: Int64 = 0
    
    let database = DataBase.shareInstance
    
    var nCheck: Bool = true
    
    var idPetSelect: Int64 = 0
    
    var pets = [Pet]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.idEvenChanging = AddEven.shareInstance.idEvenChanging
        self.nCheck = TimeLineViewController.shareInstance.nCheckEvens
        
        if self.nCheck == true {
            self.photoPicker.isHidden = false
        } else {
            makeViewChange(id_Pet: TimeLineViewController.shareInstance.idPetSelect, id_Even: idEvenChanging)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pets = database.getPets()
        idPetSelect = TimeLineViewController.shareInstance.idPetSelect
        
        setTapGesture()
        setButtonForRightBarNavi()
    }
    
    func setButtonForRightBarNavi() {
        self.title = "Add Photo"
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func save() {
        
        if self.nCheck == true {
            let date: String = database.convertName()
            database.addDataEven(id_pet: idPetSelect, date_even: date, text_even: tfCaption.text!, image_videoPath: date)
            
            if checkIDPetForTimeline(path: kTimelines) == true {
                creatTimelineImagePets()
            }
            saveImageDocumentDirectory(name: "\(date).jpeg")
            
        } else {
            changeCaption(id_Even: idEvenChanging, id_pet: idPetSelect, caption: tfCaption.text!)
        }
     
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveImageDocumentDirectory(name: String){
        let fileManager = FileManager.default
        let paths = (kTimelines + "/\(idPetSelect)" as NSString)
            .appendingPathComponent(name)
        
        let image = photoPicker.image
//        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
 
    func checkIDPetForTimeline(path: String) -> Bool {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            return true
        }
        else {
            return false
        }
    }
    func creatTimelineImagePets() {
        let mainFolder = kTimelines + "/\(idPetSelect)"
        do {
            try FileManager.default.createDirectory(atPath: mainFolder, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
 
    func setTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photoPicker.isUserInteractionEnabled = true
        photoPicker.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoPicker.image = selectPhoto
        dismiss(animated: true, completion: nil)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func changeCaption(id_Even: Int64, id_pet: Int64, caption: String) {
        database.updateEven(id_Even: id_Even, id_pet: id_pet, text_even: caption)
    }
    
    func makeViewChange(id_Pet: Int64, id_Even: Int64) {
        self.photoPicker.isHidden = true
        
        var evens = [Even]()
        evens = database.getEven(id_Pet)
        
        let evenSelect: Int = Int(id_Even) - 1
        self.tfCaption.text = evens[evenSelect].text_even
    }
}
