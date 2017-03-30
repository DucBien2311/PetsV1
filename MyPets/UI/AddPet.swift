//
//  AddPet.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class AddPet: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageAvatarPet: UIImageView!
    @IBOutlet weak var btnChooseImagePets: UIButton!
    @IBOutlet weak var btnChooseKind: UIButton!
    @IBOutlet weak var btnChooseGender: UIButton!
    @IBOutlet weak var tfDateTime: UITextField!
    @IBOutlet weak var tfNamePet: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!

    var dropMenu: DropdownMenu!
    var dateFormatter: DateFormatter!
    var deadline = Date()

    fileprivate let database = DataBase.shareInstance

    var nCheckChangInfor: Bool = true

    var idPetSelect: Int64 = 0
    var pets = [Pet]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.idPetSelect = TimeLineViewController.shareInstance.idPetSelect
        self.nCheckChangInfor = TimeLineViewController.shareInstance.nCheckPets


        setButtonForRightBarNavi()
        setLayerForButton()
        if TimeLineViewController.shareInstance.nCheckLoadData == true {
            loadDataToUpDate()
            TimeLineViewController.shareInstance.nCheckLoadData = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tfDateTime.isUserInteractionEnabled = false
        setLayerForButton()

        pets = database.getPets()
        btnChooseGender.setTitle("Choose Gender", for: .normal)
        btnChooseKind.setTitle("Choose Kind", for: .normal)
    }

    override func viewDidLayoutSubviews() {
        setImageViewCircle()
    }

    func setImageViewCircle(){
        imageAvatarPet.layer.cornerRadius = imageAvatarPet.frame.size.width/2
        imageAvatarPet.clipsToBounds = true
    }

    func setButtonForRightBarNavi(){
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
        if nCheckChangInfor {
            self.title = "Add Pets"
        } else {
            self.title = "Change Infor"
        }
    }

    func setLayerForButton() {
        btnChooseImagePets.layer.cornerRadius = 5
        btnChooseImagePets.backgroundColor = UIColor.orange
        btnChooseImagePets.layer.borderWidth = 0.1
        btnChooseImagePets.titleLabel?.tintColor = UIColor.white

        btnChooseKind.layer.cornerRadius = 5
        btnChooseKind.backgroundColor = UIColor.orange
        btnChooseKind.layer.borderWidth = 0.1

        btnChooseGender.layer.cornerRadius = 5
        btnChooseGender.backgroundColor = UIColor.orange
        btnChooseGender.layer.borderWidth = 0.1
    }

    func setDataTime() {
        deadlinePicker.datePickerMode = UIDatePickerMode.dateAndTime
        self.view.addSubview(deadlinePicker)
        deadlinePicker.addTarget(self, action: #selector(AddPet.date_time_picker_change_action(_:)), for: UIControlEvents.valueChanged)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd ' -:- ' H:mm"
    }

    func checkNull() -> Bool {
        if tfNamePet.text == "" {
            let alert = UIAlertController(title: "Warning", message: "You must enter a name pet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }

    func save(){
        if checkNull() == true {
            checkNull()
        }
        else
        {

            let imageName = database.convertName()
            if self.nCheckChangInfor == true {
                database.addDataPets(name: tfNamePet.text!, kind: (btnChooseKind.titleLabel?.text!)!, gender: (btnChooseGender.titleLabel?.text!)!, dateOfBirtth: tfDateTime.text!, petAvata: imageName)
            } else {
                database.updatePet(id: idPetSelect, name: tfNamePet.text!, kind: (btnChooseKind.titleLabel?.text!)!, gender: (btnChooseGender.titleLabel?.text!)!, dateOfBirtth: tfDateTime.text!, petAvata: imageName)
            }

            if checkNameFolderPet(path: kPets) == true {
                creatPetFolderName()
            }
            saveImageDocumentDirectory(name: "\(imageName).jpeg")
            self.navigationController?.popViewController(animated: true)
        }
    }

    func saveImageDocumentDirectory(name: String){
        let fileManager = FileManager.default
        let paths = (kPets + "/\(tfNamePet.text!)"as NSString).appendingPathComponent(name)


        let image = imageAvatarPet.image
        //        print("AAAAA: \(paths)")
        let imageData = UIImageJPEGRepresentation(image!, 1)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }

    func creatPetFolderName() {
        let mainFolder = kPets + "/\(tfNamePet.text!)"
        do {
            try FileManager.default.createDirectory(atPath: mainFolder, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }

    func checkNameFolderPet(path: String) -> Bool {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            return true
        }
        else {
            return false
        }
    }

    func loadDataToUpDate() {
        if nCheckChangInfor == false {
            let index: Int = Int(idPetSelect) - 1

            let imageUrl = URL(fileURLWithPath: kPets + "/\(pets[index].name)" + "/\(pets[index].petAvata).jpeg")
            let data = try? Data(contentsOf: imageUrl)

            imageAvatarPet.image = UIImage(data: data!)
            tfNamePet.text = pets[index].name
            btnChooseKind.setTitle(pets[index].kind, for: .normal)
            btnChooseGender.setTitle(pets[index].gender, for: .normal)
            tfDateTime.text = pets[index].dateOfBirth
        }
    }

    @IBAction func btnChooseImagePetAction(_ sender: UIButton) {

        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


    @IBAction func btnChooseKindAction(_ sender: UIButton) {

        dropMenu = DropdownMenu(frame: CGRect(x: btnChooseKind.center.x - (btnChooseKind.bounds.size.width / 2), y: btnChooseKind.center.y + (btnChooseKind.bounds.size.height / 2), width: btnChooseKind.bounds.size.width, height: btnChooseKind.bounds.size.height * 3))
        dropMenu.delegate = self
        self.view.addSubview(dropMenu)
        dropMenu.addTableView()
        dropMenu.selectedButton(index: 1)
        btnChooseKind.isEnabled = false
        btnChooseGender.isEnabled = false
    }

    @IBAction func btnChooseGenderAction(_ sender: UIButton) {

        dropMenu = DropdownMenu(frame: CGRect(x: btnChooseGender.center.x - (btnChooseGender.bounds.size.width / 2), y: btnChooseGender.center.y + (btnChooseGender.bounds.size.height / 2), width: btnChooseGender.bounds.size.width, height: btnChooseGender.bounds.size.height * 3))
        dropMenu.delegate = self
        self.view.addSubview(dropMenu)
        dropMenu.addTableView()
        dropMenu.selectedButton(index: 2)
        btnChooseGender.isEnabled = false
        btnChooseKind.isEnabled = false
    }

    @IBAction func date_time_picker_change_action(_ sender: UIDatePicker) {

        setDataTime()
        tfDateTime.text = dateFormatter.string(from: sender.date)
    }
}

extension AddPet: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageAvatarPet.contentMode = .scaleAspectFill
            imageAvatarPet.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddPet: ChooseDelegate {
    func chooseGender(index: Int) {

        if index == 0
        {
            setGenderButtonTitle(gender: "Male")
        }else
        {
            setGenderButtonTitle(gender: "Female")
        }
    }

    func setGenderButtonTitle(gender: String)
    {
        btnChooseGender.setTitle(gender, for: .normal)
        btnChooseGender.titleLabel?.textAlignment = .center
        btnChooseGender.isEnabled = true
        btnChooseKind.isEnabled = true
        dropMenu.tableView.isHidden = true
    }

    func chooseKind(index: Int) {
        switch index {
        case 0:
            setKindButtonTitle(kind: "Dog")
        case 1:
            setKindButtonTitle(kind: "Cat")
        case 2:
            setKindButtonTitle(kind: "Fish")
        case 3:
            setKindButtonTitle(kind: "Bird")
        case 4:
            setKindButtonTitle(kind: "Mouse")
        case 5:
            setKindButtonTitle(kind: "Rabbit")
        case 6:
            setKindButtonTitle(kind: "Other")
        default:
            break
        }
    }

    func setKindButtonTitle(kind: String)
    {
        btnChooseKind.setTitle(kind, for: .normal)
        btnChooseKind.titleLabel?.textAlignment = .center
        btnChooseKind.isEnabled = true
        btnChooseGender.isEnabled = true
        dropMenu.tableView.isHidden = true
    }
}
