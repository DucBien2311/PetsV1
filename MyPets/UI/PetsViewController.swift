//
//  PetsViewController.swift
//  MyPets
//
//  Created by Tuuu on 1/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {
    
    @IBOutlet weak var table_Pets: UITableView!
    
    let database = DataBase.shareInstance
    fileprivate var pets = [Pet]()
    fileprivate var petsImage = [PetImage]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pets = database.getPets()
        table_Pets.reloadData()
        
        TimeLineViewController.shareInstance.nCheckPets = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_Pets.dataSource = self
        table_Pets.delegate = self
        
        let cellPet = UINib(nibName: "CellPets", bundle: nil)
        table_Pets.register(cellPet, forCellReuseIdentifier: "CellPet")
        pets = database.getPets()
        petsImage = database.getImagePets(1)
        
        setButtonForRightBarNavi()
    }
    
    func setButtonForRightBarNavi(){
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPet))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func addNewPet(){
        let VC = AddPet(nibName: "AddPet", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}


extension PetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_Pets.dequeueReusableCell(withIdentifier: "CellPet", for: indexPath) as! CellPets
        
        cell.lbl_NamePet.text = pets[indexPath.row].name
        cell.lbl_DatePet.text = pets[indexPath.row].dateOfBirth
        cell.lbl_KindGender.text = "\(pets[indexPath.row].kind) - \(pets[indexPath.row].gender)"
        
        let imageUrl = URL(fileURLWithPath: kPets + "/\(pets[indexPath.row].name)" + "/\(pets[indexPath.row].petAvata).jpeg")
        let data = try? Data(contentsOf: imageUrl)
        
        cell.img_Pet.image = UIImage(data: data!)
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.92, alpha: 1.0)
    
        cell.layer.shadowColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 0.25
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            if let petView = table_Pets
            {
                let idDelete = pets[indexPath.row].id
                database.deleteDataPets(ID: idDelete!)
                
                pets.remove(at: indexPath.row)
                petView.deleteRows(at: [indexPath], with: .fade)
            }
        }        
    }
}

extension PetsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        TimeLineViewController.shareInstance.idPetSelect = Int64(indexPath.row) + Int64(1)
        
        let VC = TimeLineViewController(nibName: "TimeLineViewController", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
